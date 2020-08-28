//
//  BXKNetworkCenter.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import "BXKNetworkCenter.h"
#import "BXKConst.h"
#import "BXKNetworkCenter+Private.h"
#import <CommonCrypto/CommonDigest.h>

static NSString * const BXKNetAPIURLString = @"https://bxapi.dataoke.com/api/wap/component/pool";

@interface BXKNetworkCenter ()

/// 基础网络请求
/// @param URLString 请求地址
/// @param method 请求方式 GET 或 POST
/// @param params 请求参数
/// @param completionHandler 请求结果回调
- (void)requestWithURLString:(NSString *)URLString
                method:(NSString *)method
                params:(NSDictionary *)params
     completionHandler:(BXKNetworkCallback)completionHandler;

/// 生成所有请求参数
/// @param params 业务参数
- (NSDictionary *)generateAllParams:(NSDictionary *)params;

/// 处理请求结果
/// @param responseObject 请求结果
/// @param error 错误信息
/// @param callback 回调函数
- (void)handlerResponseObject:(id)responseObject error:(NSError *)error callback:(BXKNetworkCallback)callback;

@end

@implementation BXKNetworkCenter

#pragma mark - Init

+ (instancetype)sharedClient {
    static BXKNetworkCenter *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BXKNetworkCenter alloc] initWithBaseURL:nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


#pragma mark - Public

- (void)requestWithParams:(NSDictionary *)params
        completionHandler:(BXKNetworkCallback)completionHandler {
    [self requestWithURLString:BXKNetAPIURLString method:@"GET" params:params completionHandler:completionHandler];
}

#pragma mark - Private

- (void)requestWithURLString:(NSString *)URLString
                      method:(NSString *)method
                      params:(NSDictionary *)params
           completionHandler:(BXKNetworkCallback)completionHandler {
    if ([method isEqualToString:@"POST"]) {
        [self POST:URLString parameters:[self generateAllParams:params] headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    } else {
        [self GET:URLString parameters:[self generateAllParams:params] headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [self handlerResponseObject:responseObject error:nil callback:completionHandler];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self handlerResponseObject:nil error:error callback:completionHandler];
        }];
    }
}

- (NSDictionary *)generateAllParams:(NSDictionary *)params {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    allParams[@"appKey"] = self.key;
    allParams[@"client"] = @"wap";
    if (params.count > 0) {
        [allParams addEntriesFromDictionary:params];
    }
    
    NSMutableString *allParamsString = [NSMutableString string];
    
    NSArray *sortKeys = [allParams.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *sortKey in sortKeys) {
        NSString *value = allParams[sortKey];
        [allParamsString appendFormat:@"%@=%@&", sortKey, value];
    }
    [allParamsString appendFormat:@"key=%@", self.secret];
    
    NSString *sign = [BXKNetworkCenter md5:allParamsString];
    allParams[@"sign"] = sign;
    return allParams;
}

- (void)handlerResponseObject:(id)responseObject error:(NSError *)error callback:(BXKNetworkCallback)callback {
    if (callback == nil) {
        return;
    }
    
    callback(responseObject, error);
}

+ (NSString *)md5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}

@end
