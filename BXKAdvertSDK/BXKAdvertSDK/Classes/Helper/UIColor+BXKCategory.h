//
//  UIColor+BXKCategory.h
//  BXKAdvertSDK
//
//  Created by CxDtreeg on 2020/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BXKCategory)

+ (instancetype)initWithHex:(NSInteger)hex;
+ (instancetype)initWithHex:(NSInteger)hex alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END
