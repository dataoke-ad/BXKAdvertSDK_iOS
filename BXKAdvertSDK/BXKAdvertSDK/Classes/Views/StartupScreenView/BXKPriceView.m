//
//  BXKPriceView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKPriceView.h"
#import "NSString+BXKCategory.h"

@implementation BXKPriceView

- (void)initSubviews {
    [self addSubview:self.symbolLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.originalPriceLabel];
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.center.equalTo(self).offset(6.5);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.top.equalTo(self);
        make.height.mas_equalTo(42);
    }];
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(6);
        make.centerY.equalTo(self).offset(6.5);
        make.right.equalTo(self);
    }];
}

- (void)setPrice:(CGFloat)price originalPrice:(CGFloat)originalPrice {
    
    NSString *priceText = [NSString stringWithFormat:@"%f", price].clipZero;
    NSString *originalPriceText = [@"¥" stringByAppendingString: [NSString stringWithFormat:@"%f", originalPrice].clipZero];
    self.priceLabel.text = priceText;
    
    NSAttributedString *attrPrice = [[NSAttributedString alloc] initWithString: originalPriceText attributes:@{NSStrikethroughStyleAttributeName: @1}];
    self.originalPriceLabel.attributedText = attrPrice;
}

#pragma mark - Custom Accessors

- (UILabel *)symbolLabel {
    if (_symbolLabel == nil) {
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.textColor = [UIColor whiteColor];
        _symbolLabel.text = @"￥";
        _symbolLabel.font = [UIFont systemFontOfSize:12];
    }
    return _symbolLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.font = [UIFont boldSystemFontOfSize:30];
    }
    return _priceLabel;
}

- (UILabel *)originalPriceLabel {
    if (_originalPriceLabel == nil) {
        _originalPriceLabel = [[UILabel alloc] init];
        _originalPriceLabel.font = [UIFont boldSystemFontOfSize:12];
        _originalPriceLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
    return _originalPriceLabel;
}

@end
