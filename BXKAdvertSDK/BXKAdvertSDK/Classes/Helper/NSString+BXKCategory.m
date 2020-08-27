//
//  NSString+BXKCategory.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "NSString+BXKCategory.h"

@implementation NSString (BXKCategory)

- (NSString *)clipZero {
    double value = self.doubleValue;
    if (fmodf(value, 1)==0) {
        return [NSString stringWithFormat:@"%.0f", value];
    } else if (fmodf(value*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f", value];
    } else {
        return [NSString stringWithFormat:@"%.2f", value];
    }
    return self;
}

- (NSString *)capitalNum {
    long long value = self.longLongValue;
    if (value < 10000) {
        return self;
    } else {
        return [NSString stringWithFormat:@"%lld万", (value/10000)];
    }
}

@end
