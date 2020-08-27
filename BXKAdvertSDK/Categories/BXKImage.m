//
//  BXKImage.m
//  AFNetworking
//
//  Created by Chauncy_X on 2020/8/26.
//  Copyright © 2020 Dataoke. All rights reserved.
//

#import "BXKImage.h"
#import <Foundation/Foundation.h>


@implementation BXKImage

+ (NSBundle *)bxkBundle {
    NSBundle *bundle = [NSBundle bundleForClass: self];
    return bundle;
}

+ (NSBundle *)resourceBundle {
    NSURL *url = [NSBundle.mainBundle URLForResource:@"BXKAdvertSDK" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:url];
    return bundle;
}

+ (UIImage *)imageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name
                                inBundle:[self bxkBundle]
           compatibleWithTraitCollection:nil];
    
    if (image != nil) return image;
    
    image = [UIImage imageNamed:name
                       inBundle:[self resourceBundle]
  compatibleWithTraitCollection:nil];
    
    if (image != nil) return image;
    
    
    return image;
}

@end
