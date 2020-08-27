//
//  BXKAdvert.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKAdvert.h"
#import "BXKNetworkCenter.h"
#import "BXKAdvertDelegate.h"
#import "BXKStartupScreenView.h"
#import "BXKInfoFlowView.h"
#import "BXKSearchView.h"
#import "BXKFloaterView.h"
#import "BXKSmartAlertView.h"

@interface BXKAdvert ()

@property (nonatomic, strong) NSString *keyword;

@end

@implementation BXKAdvert

#pragma mark - BXKAdvertProtocol

- (instancetype)initWithType:(BXKAdvertType)type
                       comId:(NSString *)comId
                    delegate:(id<BXKAdvertDelegate>)delegate {
    self = [super init];
    if (self) {
        self.type = type;
        self.comId = comId;
        self.delegate = delegate;
    }
    return self;
}

- (void)startRequest {
    if (self.type == BXKAdvertTypeSearchBar) {
        BXKSearchView *searchView = [[BXKSearchView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        searchView.click = ^(NSString *keyword) {
            weakSelf.keyword = keyword;
            [[BXKNetworkCenter sharedClient] requestWithParams:[self buildParams] completionHandler:^(id response, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.response = response;
                    [weakSelf handlerResponse:weakSelf.response error:error];
                });
            }];
        };
        self.view = searchView;
        if ([self.delegate respondsToSelector:@selector(advert:didRequestSuccess:)]) {
            [self.delegate advert:self didRequestSuccess:self.response];
        }
        
        return;
    }
    
    [[BXKNetworkCenter sharedClient] requestWithParams:[self buildParams] completionHandler:^(id response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.response = response;
            [self handlerResponse:self.response error:error];
        });
    }];
}


#pragma mark - Private

- (NSDictionary *)buildParams {
    if (![self.comId isKindOfClass:[NSString class]] ||
        self.comId.length == 0) {
        return nil;
    }
    
    if (self.type == BXKAdvertTypeSearchBar && self.keyword.length > 0) {
        return @{@"comId": self.comId, @"keywords": self.keyword};
    } else {
        return @{@"comId": self.comId};
    }
}

- (void)handlerResponse:(NSDictionary *)response error:(NSError *)error {
    NSInteger code = [response[@"code"] integerValue];
    NSString *msg = response[@"msg"];
    if (code == 1) {
        switch (self.type) {
            case BXKAdvertTypeStartupScreen:
                [self handlerStartupScreen];
                break;
            case BXKAdvertTypeInfoFlow:
                [self handlerInfoFlow];
                break;
            case BXKAdvertTypeSearchBar:
                [self handlerSearchBar];
                break;
            case BXKAdvertTypeFloater:
                [self handleFloater];
                break;
            case BXKAdvertTypePopUp:
                [self handlerSmartAlertView];
                break;
            default:
                if ([self.delegate respondsToSelector:@selector(advert:didRequestSuccess:)]) {
                    [self.delegate advert:self didRequestSuccess:self.response];
                }
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(advert:didRequestFailure:)]) {
            NSError *aError = [NSError errorWithDomain:BXKDomain code:code userInfo:@{@"msg": msg ? :@"未知错误"}];
            [self.delegate advert:self didRequestFailure:aError];
        }
    }
}

- (void)handlerStartupScreen {
    BXKStartupScreenView *startupScreenView = [[BXKStartupScreenView alloc] initWithDictionary:self.response];
    if (startupScreenView == nil) {
        if ([self.delegate respondsToSelector:@selector(advert:didRequestFailure:)]) {
            NSError *aError = [NSError errorWithDomain:BXKDomain code:BXKAdvertSDKErrorCodeService userInfo:@{@"msg": @"json数据异常"}];
            [self.delegate advert:self didRequestFailure:aError];
        }
    } else {
        __weak typeof(self) weakSelf = self;
        startupScreenView.click = ^(NSString *landingLink) {
            if ([weakSelf.delegate respondsToSelector:@selector(advert:didClickWithLandingLink:)]) {
                [weakSelf.delegate advert:weakSelf didClickWithLandingLink:landingLink];
            }
        };
        
        self.view = startupScreenView;
        
        if ([self.delegate respondsToSelector:@selector(advert:didRequestSuccess:)]) {
            [self.delegate advert:self didRequestSuccess:self.response];
        }
    }
}

// 处理信息流数据
- (void)handlerInfoFlow {
    BXKInfoFlowView * infoFlowView = [[BXKInfoFlowView alloc] initWithDictionary:self.response];
    if (infoFlowView == nil) {
        if ([self.delegate respondsToSelector:@selector(advert:didRequestFailure:)]) {
            NSError *aError = [NSError errorWithDomain:BXKDomain code:BXKAdvertSDKErrorCodeService userInfo:@{@"msg": @"json数据异常"}];
            [self.delegate advert:self didRequestFailure:aError];
        }
    }else {
        __weak typeof(self) weakSelf = self;
        infoFlowView.click = ^(NSString *landingLink) {
            if ([weakSelf.delegate respondsToSelector:@selector(advert:didClickWithLandingLink:)]) {
                [weakSelf.delegate advert:weakSelf didClickWithLandingLink:landingLink];
            }
        };
        self.view = infoFlowView;
        
        if ([self.delegate respondsToSelector:@selector(advert:didRequestSuccess:)]) {
            [self.delegate advert:self didRequestSuccess:self.response];
        }
    }
}

- (void)handlerSearchBar {
    NSString *landingLink = self.response[@"data"][@"mall_url"];
    if (landingLink.length == 0) {
        if ([self.delegate respondsToSelector:@selector(advert:didRequestFailure:)]) {
            NSError *aError = [NSError errorWithDomain:BXKDomain code:BXKAdvertSDKErrorCodeService userInfo:@{@"msg": @"json数据异常"}];
            [self.delegate advert:self didRequestFailure:aError];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(advert:didClickWithLandingLink:)]) {
            [self.delegate advert:self didClickWithLandingLink:landingLink];
        }
    }
}

- (void)handleFloater {
    BXKFloaterView *floaterView = [[BXKFloaterView alloc] initWithDictionary:self.response];
    if (floaterView == nil) {
        if ([self.delegate respondsToSelector:@selector(advert:didRequestFailure:)]) {
            NSError *aError = [NSError errorWithDomain:BXKDomain code:BXKAdvertSDKErrorCodeService userInfo:@{@"msg": @"json数据异常"}];
            [self.delegate advert:self didRequestFailure:aError];
        }
    } else {
        __weak typeof(self) weakSelf = self;
        floaterView.click = ^(NSString *landingLink) {
            if ([weakSelf.delegate respondsToSelector:@selector(advert:didClickWithLandingLink:)]) {
                [weakSelf.delegate advert:weakSelf didClickWithLandingLink:landingLink];
            }
        };
        
        self.view = floaterView;
        
        if ([self.delegate respondsToSelector:@selector(advert:didRequestSuccess:)]) {
            [self.delegate advert:self didRequestSuccess:self.response];
        }
    }
}

- (void)handlerSmartAlertView {
    BXKSmartAlertView *smartAlertView = [[BXKSmartAlertView alloc] initWithDictionary:self.response];
    if (smartAlertView == nil) {
        if ([self.delegate respondsToSelector:@selector(advert:didRequestFailure:)]) {
            NSError *aError = [NSError errorWithDomain:BXKDomain code:BXKAdvertSDKErrorCodeService userInfo:@{@"msg": @"json数据异常"}];
            [self.delegate advert:self didRequestFailure:aError];
        }
    } else {
        __weak typeof(self) weakSelf = self;
        smartAlertView.click = ^(NSString *landingLink) {
            if ([weakSelf.delegate respondsToSelector:@selector(advert:didClickWithLandingLink:)]) {
                [weakSelf.delegate advert:weakSelf didClickWithLandingLink:landingLink];
            }
        };
        
        [smartAlertView show];
        self.view = smartAlertView;
        
        if ([self.delegate respondsToSelector:@selector(advert:didRequestSuccess:)]) {
            [self.delegate advert:self didRequestSuccess:self.response];
        }
    }
}

#pragma mark - Custom Accessors

- (void)setView:(UIView *)view {
    [_view removeFromSuperview];
    _view = view;
}

@end
