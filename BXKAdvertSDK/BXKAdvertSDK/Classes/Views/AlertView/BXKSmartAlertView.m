//
//  BXKSmartAlertView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/26.
//

#import "BXKSmartAlertView.h"

@interface BXKSmartAlertView ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation BXKSmartAlertView

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        NSString *front_img = dictionary[@"data"][@"front_img"];
        if (front_img.length == 0) {
            return nil;
        }
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:front_img]];
    }
    return self;
}

- (void)initSubviews {
    [super initSubviews];
    [self addSubview:self.imageView];
    [self addSubview:self.closeButton];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) < 321 ? 270 : 325;

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-60);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(40);
    }];
}

#pragma mark - Public

- (void)show {
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - IBActions

- (void)imageViewDidTap:(UITapGestureRecognizer *)tap {
    if (self.click) {
        [self.closeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        NSString *mall_url = self.dictionary[@"data"][@"mall_url"];
        self.click(mall_url);
    }
}

- (void)closeBottonDidClicked:(UIButton *)sender {
    [self dismiss];
}

#pragma mark - Custom Accessors

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage bundleImageNamed:@"bxk_close"] forState:UIControlStateNormal];
        [_closeButton setImage:[UIImage bundleImageNamed:@"bxk_close"] forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(closeBottonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end
