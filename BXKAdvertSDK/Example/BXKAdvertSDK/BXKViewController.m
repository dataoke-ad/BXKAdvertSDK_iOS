//
//  BXKViewController.m
//  BXKAdvertSDK
//
//  Created by chenweitao on 08/24/2020.
//  Copyright (c) 2020 chenweitao. All rights reserved.
//

#import "BXKViewController.h"
#import <BXKAdvertSDK/BXKAdvertSDK.h>
#import "BXKTestViewController.h"
#import "BXKWebViewController.h"

#define SDKKey     @"0df59c13"
#define SDKAppKey @"4351e56096c6c4410bd3094bbc862b2e"

@interface BXKViewController ()
<BXKAdvertDelegate>

@property (nonatomic, copy) NSArray *comIds;
@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

@implementation BXKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [BXKAdvertSDK registerWithKey:SDKKey appKey:SDKAppKey];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *comId = self.comIds[indexPath.row];
    self.advert = [BXKAdvertFactory createWithType:indexPath.row+1 comId:comId delegate:self];
    [self.advert startRequest];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - BXKAdvertDelegate

-(void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response {
    
    BXKTestViewController *vc = [[BXKTestViewController alloc] init];
    vc.advert = advert;
    
    switch (advert.type) {
        case BXKAdvertTypeStartupScreen: {
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
        case BXKAdvertTypeInfoFlow:
        case BXKAdvertTypeSearchBar: {
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case BXKAdvertTypePopUp: {
            // 内部已将视图加载到keyWindow
            break;
        }
        case BXKAdvertTypeFloater: {
            CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
            CGFloat screenHeight = CGRectGetHeight(self.view.bounds);
            advert.view.frame = CGRectMake(screenWidth-114-20, screenHeight-300, 114, 114);
            [self.view addSubview:advert.view];
            break;
        }
        default:
            break;
    }
}

- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error {
    
}

-(void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink {
    [self dismissViewControllerAnimated:YES completion:nil];
    BXKWebViewController *webVC = [[BXKWebViewController alloc] init];
    webVC.URLString = landingLink;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - Custom Accessors

- (NSArray *)comIds {
    if (_comIds == nil) {
        _comIds = @[@"2623", @"2621", @"2622", @"2620", @"2624"];
    }
    return _comIds;
}

@end
