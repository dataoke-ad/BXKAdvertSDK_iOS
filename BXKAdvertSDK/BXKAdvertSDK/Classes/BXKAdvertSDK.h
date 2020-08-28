//
//  BXKAdvertSDK.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import <Foundation/Foundation.h>
#import "BXKAdvertFactory.h"

#define BXKAdvertSDKVersion @"0.0.1"

@interface BXKAdvertSDK : NSObject

/// 注册SDK
/// @param key
/// @param secret
+ (void)registerWithKey:(NSString *)key secret:(NSString *)secret;

@end
