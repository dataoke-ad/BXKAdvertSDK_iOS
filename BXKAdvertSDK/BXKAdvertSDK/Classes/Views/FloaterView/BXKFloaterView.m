//
//  BXKFloaterView.m
//  AFNetworking
//
//  Created by Chauncy_X on 2020/8/25.
//  Copyright © 2020 Dataoke. All rights reserved.
//

#import "BXKFloaterView.h"
#import "UIImage+BXKCategory.h"

@interface BXKFloaterView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *closeImage;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation BXKFloaterView

#pragma mark - Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.dictionary = dictionary;
        
        NSString *imageURLStr = dictionary[@"data"][@"front_img"];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        if (!imageURL) return nil;
        
        [self.imageView sd_setImageWithURL:imageURL];
        [self.imageView sd_setImageWithURL:imageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.hidden = image == nil;
        }];
    }
    return self;
}

- (void)initSubviews {
    [super initSubviews];
    
    [self addSubview:self.imageView];
    [self addSubview:self.closeImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_onTap:)];
    [self addGestureRecognizer:tap];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.edges.mas_equalTo(UIEdgeInsetsMake(14, 0, 0, 14));
    }];
    [self.closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.right.equalTo(self);
    }];
}



#pragma mark -  Actions

- (void)_onTap:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self];
    if (CGRectContainsPoint(_imageView.frame, location)) {
        if (self.click) {
            NSString *landingLink = self.dictionary[@"data"][@"mall_url"];
            self.click(landingLink);
        }
    } else if (CGRectContainsPoint(_closeImage.frame, location)) {
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

#pragma mark -  view

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UIImageView *)closeImage {
    if (!_closeImage) {
        UIImage *image = [UIImage bundleImageNamed:@"bxk_floater_close"];
        _closeImage = [[UIImageView alloc] initWithImage:image];
    }
    return _closeImage;
}

@end
