//
//  BXKAdvertProtocol.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import <Foundation/Foundation.h>
#import "BXKConst.h"

@protocol BXKAdvertDelegate;
@protocol BXKAdvertProtocol <NSObject>

@required
/// 广告id
- (NSString *)comId;

/// 广告类型
- (BXKAdvertType)type;

/// 代理对象
- (id<BXKAdvertDelegate>)delegate;

/// 广告视图
- (UIView *)view;

/// 广告数据
- (NSDictionary *)response;

/// 开始请求广告，结果通过delegate通知
- (void)startRequest;

/// 初始化广告对象
/// @param type 广告类型
/// @param comId 广告id
/// @param delegate 代理对象
- (instancetype)initWithType:(BXKAdvertType)type comId:(NSString *)comId delegate:(id<BXKAdvertDelegate>)delegate;

@end
