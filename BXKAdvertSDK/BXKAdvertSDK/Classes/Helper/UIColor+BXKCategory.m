//
//  UIColor+BXKCategory.m
//  BXKAdvertSDK
//
//  Created by CxDtreeg on 2020/8/26.
//

#import "UIColor+BXKCategory.h"

@implementation UIColor (BXKCategory)

+ (instancetype)initWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((hex & 0xFF00) >> 8) / 255.0;
    CGFloat b = (hex & 0xFF) / 255.0;
    return [[UIColor alloc] initWithRed:r green:g blue:b alpha:alpha];
}

+ (instancetype)initWithHex:(NSInteger)hex {
    return [self initWithHex:hex alpha:1];
}


@end
