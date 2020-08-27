//
//  BXKCouponView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKCouponView.h"
#import "NSString+BXKCategory.h"

@implementation BXKCouponView

- (void)initSubviews {
    [super initSubviews];
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.couponLabel];
    [self addSubview:self.digitLabel];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(6);
    }];
    [self.digitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-7);
        make.centerY.equalTo(self);
    }];
}


#pragma mark - Public

- (void)setCoupon:(CGFloat)coupon {
    if (coupon <1e-5) {
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
    self.digitLabel.text = [@"¥" stringByAppendingString:[NSString stringWithFormat:@"%f", coupon].clipZero];
}

#pragma mark - Custom Accessors

- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [[UIImage bundleImageNamed:@"bxk_couponBg"] stretchableImageWithLeftCapWidth:33 topCapHeight:12];
    }
    return _backgroundImageView;
}

- (UILabel *)couponLabel {
    if (_couponLabel == nil) {
        _couponLabel = [[UILabel alloc] init];
        _couponLabel.text = @"券";
        _couponLabel.font = [UIFont boldSystemFontOfSize:12];
        _couponLabel.textColor = [UIColor colorWithRed:1 green:31/255.0 blue:76/255.0 alpha:1];
    }
    return _couponLabel;
}

- (UILabel *)digitLabel {
    if (_digitLabel == nil) {
        _digitLabel = [[UILabel alloc] init];
        _digitLabel.textColor = [UIColor whiteColor];
        _digitLabel.font = [UIFont boldSystemFontOfSize:14];
        _digitLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _digitLabel;
}

@end
