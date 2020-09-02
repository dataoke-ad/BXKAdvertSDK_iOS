//
//  BXKAdvertSDK.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import <Foundation/Foundation.h>
#import "BXKAdvertFactory.h"

#define BXKAdvertSDKVersion @"1.0.0"

@interface BXKAdvertSDK : NSObject

/// 注册SDK
+ (void)registerWithKey:(NSString *)key appKey:(NSString *)appKey;

@end
