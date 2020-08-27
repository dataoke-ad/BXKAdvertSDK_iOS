//
//  UIImage+BXKCategory.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import <UIKit/UIKit.h>

#define bxk_UIColorFromRGB(rgbValue)                                 \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                 blue:((float)(rgbValue & 0xFF)) / 255.0             \
                alpha:1.0]

#define bxk_UIColorFromRGBA(rgbaValue)                                  \
[UIColor colorWithRed:((float)((rgbaValue & 0xFF000000) >> 32)) / 255.0 \
                green:((float)((rgbaValue & 0xFF0000) >> 16)) / 255.0   \
                 blue:((float)((rgbaValue & 0xFF00) >> 8)) / 255.0      \
                alpha:((float)(rgbaValue & 0xFF)) / 255.0

@interface UIImage (BXKCategory)

+ (UIImage *)bundleImageNamed:(NSString *)name;

@end
