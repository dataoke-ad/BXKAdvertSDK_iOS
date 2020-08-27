//
//  BXKTestViewController.m
//  BXKAdvertSDK_Example
//
//  Created by wit on 2020/8/26.
//  Copyright © 2020 Dataoke. All rights reserved.
//

#import "BXKTestViewController.h"
#import <Masonry/Masonry.h>

@interface BXKTestViewController ()

@end

@implementation BXKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.advert.type) {
        case BXKAdvertTypeStartupScreen: {
            [self.view addSubview:self.advert.view];
            [self.advert.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            break;
        }
        case BXKAdvertTypeInfoFlow: {
            [self.view addSubview:self.advert.view];
            [self.advert.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(self.view);
                make.top.mas_equalTo(100);
                make.height.mas_equalTo(210);
            }];
            break;
        }
        case BXKAdvertTypeSearchBar: {
            [self.view addSubview:self.advert.view];
              [self.advert.view mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.leading.trailing.equalTo(self.view);
                  make.top.mas_equalTo(100);
                  make.height.mas_equalTo(110);
              }];
            break;
        }
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
