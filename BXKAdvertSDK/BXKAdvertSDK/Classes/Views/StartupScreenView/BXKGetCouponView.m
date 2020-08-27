//
//  BXKGetCouponView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKGetCouponView.h"

@implementation BXKGetCouponView

- (void)initSubviews {
    [self addSubview:self.priceView];
    [self addSubview:self.salesLabel];
    [self addSubview:self.shadowView];
    [self addSubview:self.buyLabel];
    
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.equalTo(self).offset(-12);
    }];
    [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceView);
        make.centerY.equalTo(self).offset(15);
    }];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.width.mas_equalTo(136);
        make.right.bottom.mas_equalTo(-6);
    }];
    [self.buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.shadowView);
    }];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, MAX(375, [UIScreen mainScreen].bounds.size.width) - 20, 80);
    gradientLayer.colors = @[
        (id)[UIColor colorWithRed:1 green:80/255.0 blue:80/255.0 alpha:1].CGColor,
    (id)[UIColor colorWithRed:1 green:52/255.0 blue:93/255.0 alpha:1].CGColor];
    gradientLayer.cornerRadius = 10;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

#pragma mark - Custom Accessors

- (BXKPriceView *)priceView {
    if (_priceView == nil) {
        _priceView = [[BXKPriceView alloc] init];
    }
    return _priceView;
}

- (UILabel *)salesLabel {
    if (_salesLabel == nil) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.textColor = [UIColor whiteColor];
        _salesLabel.font = [UIFont systemFontOfSize:11];
    }
    return _salesLabel;
}

- (UIView *)shadowView {
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.96];
        _shadowView.layer.cornerRadius = 5;
        _shadowView.layer.shadowColor = [UIColor colorWithRed:190/255.0 green:0 blue:0 alpha:0.45].CGColor;
        _shadowView.layer.opacity = 1;
        _shadowView.layer.shadowOffset = CGSizeZero;
    }
    return _shadowView;
}

- (UILabel *)buyLabel {
    if (_buyLabel == nil) {
        _buyLabel = [[UILabel alloc] init];
        _buyLabel.text = @"立即购买";
        _buyLabel.textColor = [UIColor colorWithRed:254/255.0 green:55/255.0 blue:56/255.0 alpha:1];
        _buyLabel.font = [UIFont boldSystemFontOfSize:19];
        _buyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _buyLabel;
}

@end
