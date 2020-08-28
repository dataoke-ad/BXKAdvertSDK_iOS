//
//  UIImage+BXKCategory.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "UIImage+BXKCategory.h"

@implementation UIImage (BXKCategory)

+ (UIImage *)bundleImageNamed:(NSString *)name {
    UIImage *img = [self imageNamed:[NSString stringWithFormat:@"BXKAdvertSDK.bundle/%@", name]];
    if (img == nil) {
        img = [self imageNamed:[NSString stringWithFormat:@"Frameworks/BXKAdvertSDK.framework/BXKAdvertSDK.bundle/%@", name]];
    }
    
    if (img == nil) {
        img = [self imageNamed:name];
    }
    
    if (img == nil) {
        return [self _bundleImageNamed:name];
    }
    
    return img;
}

+ (UIImage *)_bundleImageNamed:(NSString *)name {
    NSInteger scale = (NSInteger)(UIScreen.mainScreen.scale);
    NSString *imageName = [NSString stringWithFormat:@"%@@%ldx", name, scale];
    UIImage *img = [self imageNamed:[NSString stringWithFormat:@"BXKAdvertSDK.bundle/%@", imageName]];
    if (img == nil) {
        img = [self imageNamed:[NSString stringWithFormat:@"Frameworks/BXKAdvertSDK.framework/BXKAdvertSDK.bundle/%@", imageName]];
    }
    
    if (img == nil) {
        img = [self imageNamed:imageName];
    }
    
    return img;
}

@end
