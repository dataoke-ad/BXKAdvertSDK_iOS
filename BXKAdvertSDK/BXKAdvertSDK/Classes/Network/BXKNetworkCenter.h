//
//  BXKNetworkCenter.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import <Foundation/Foundation.h>

typedef void(^BXKNetworkCallback)(id, NSError *);

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@interface BXKNetworkCenter : AFHTTPSessionManager

+ (instancetype)sharedClient;

/// 请求组件数据
/// @param params 请求参数
/// @param completionHandler 请求结果回调
- (void)requestWithParams:(NSDictionary *)params
        completionHandler:(BXKNetworkCallback)completionHandler;

@end
