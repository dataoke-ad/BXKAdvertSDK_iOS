//
//  BXKAdvert.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import <Foundation/Foundation.h>
#import "BXKAdvertProtocol.h"
#import "BXKAdvertDelegate.h"

@interface BXKAdvert : NSObject
<BXKAdvertProtocol>

@property (nonatomic, weak) id<BXKAdvertDelegate> delegate;
@property (nonatomic, assign) BXKAdvertType type;
@property (nonatomic, copy) NSString *comId;

@property (nonatomic, strong) NSDictionary *response;
@property (nonatomic, strong) UIView *view;

/// 浮窗组件偏移量
@property (nonatomic, assign) CGPoint floaterOffset;
/// 浮窗尺寸
@property (nonatomic, assign) CGSize floaterSize;

@end
