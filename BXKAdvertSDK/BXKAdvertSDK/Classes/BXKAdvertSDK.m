//
//  BXKAdvertSDK.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import "BXKAdvertSDK.h"
#import "BXKAdvertFactory.h"
#import "BXKNetworkCenter.h"
#import "BXKNetworkCenter+Private.h"

@implementation BXKAdvertSDK

#pragma mark - Public

+ (void)registerWithKey:(NSString *)key appKey:(NSString *)appKey {
    [BXKNetworkCenter sharedClient].key = key;
    [BXKNetworkCenter sharedClient].appKey = appKey;
}

@end
