//
//  BXKInfoFlowGoodCell.m
//  BXKAdvertSDK
//
//  Created by CxDtreeg on 2020/8/26.
//

#import "BXKInfoFlowGoodCell.h"
#import "UIColor+BXKCategory.h"
#import "NSString+BXKCategory.h"
#import "UIImage+BXKCategory.h"

@interface BXKInfoFlowGoodCell ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *tagLabel;
@property (strong, nonatomic) UIImageView *leftTriangle;
@property (strong, nonatomic) UIImageView *rightTriangle;
@property (strong, nonatomic) UITextView *titleTextView;
@property (strong, nonatomic) UILabel *priceSymbleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *priceTagLabel;
@property (strong, nonatomic) UIImageView *couponImageView;
@property (strong, nonatomic) UILabel *couponLabel;


@end

@implementation BXKInfoFlowGoodCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self makeConstraints];
    }
    return self;
}

- (void)setGoods:(BXKGoods *)good {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:good.pic]];
    self.tagLabel.text = good.tag1;
    self.titleTextView.attributedText = good.attributedTitle;
    self.priceLabel.text = [[NSString stringWithFormat:@"%.2lf", good.jiage] clipZero];
    self.couponLabel.text = [NSString stringWithFormat:@"%.0f元券", good.quanJine];
}

- (void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.leftTriangle];
    [self.contentView addSubview:self.rightTriangle];
    [self.contentView addSubview:self.titleTextView];
    [self.contentView addSubview:self.priceSymbleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.priceTagLabel];
    [self.contentView addSubview:self.couponImageView];
    [self.couponImageView addSubview:self.couponLabel];
}

- (void)makeConstraints {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.right.mas_equalTo(-3);
        make.top.equalTo(self);
        make.height.equalTo(self.imageView.mas_width);
    }];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom);
        make.height.mas_equalTo(16);
    }];
    [_leftTriangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.tagLabel.mas_top);
    }];
    [_rightTriangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self.tagLabel.mas_top);
    }];
    [_titleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(3);
        make.right.mas_equalTo(-3);
        make.height.mas_equalTo(33);
    }];
    [_priceSymbleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.centerY.equalTo(self.priceLabel.mas_centerY).offset(2);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceSymbleLabel.mas_right).offset(1);
        make.bottom.equalTo(self);
    }];
    [_priceTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(1);
        make.centerY.equalTo(self.priceLabel.mas_centerY).offset(1);
    }];
    [_couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceTagLabel.mas_right).offset(4);
        make.centerY.equalTo(self.priceLabel.mas_centerY);
    }];
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.right.mas_equalTo(-3);
        make.centerY.equalTo(self.couponImageView);
    }];
}

#pragma mark - Propertys

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor initWithHex:0xe5e6e7];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 110, 110) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *imageMask = [CAShapeLayer new];
        imageMask.path = path.CGPath;
        _imageView.layer.mask = imageMask;
    }
    return _imageView;
}

- (UILabel *)tagLabel {
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.font = [UIFont systemFontOfSize:10];
        _tagLabel.textColor = [UIColor initWithHex:0xF57223];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.layer.cornerRadius = 0;
        _tagLabel.layer.borderWidth = 0.5;
        _tagLabel.layer.borderColor = [UIColor initWithHex:0xF57223].CGColor;
        _tagLabel.backgroundColor = [UIColor initWithHex:0xFFEAC2];
        _tagLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _tagLabel;
}

- (UIImageView *)leftTriangle {
    if (!_leftTriangle) {
        _leftTriangle = [UIImageView new];
        _leftTriangle.image = [UIImage bundleImageNamed:@"bxk_leftTriangle"];
    }
    return _leftTriangle;
}

- (UIImageView *)rightTriangle {
    if (!_rightTriangle) {
        _rightTriangle = [UIImageView new];
        _rightTriangle.image = [UIImage bundleImageNamed:@"bxk_rightTriangle"];
    }
    return _rightTriangle;
}

- (UITextView *)titleTextView {
    if (!_titleTextView) {
        _titleTextView = [UITextView new];
        _titleTextView.textContainer.maximumNumberOfLines = 2;
        _titleTextView.textContainer.lineFragmentPadding = 0;
        _titleTextView.textContainerInset = UIEdgeInsetsZero;
        _titleTextView.textColor = [UIColor initWithHex:0x333333];
        _titleTextView.font = [UIFont systemFontOfSize:12];
    }
    return _titleTextView;
}

- (UILabel *)priceSymbleLabel {
    if (!_priceSymbleLabel) {
        _priceSymbleLabel = [UILabel new];
        _priceSymbleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _priceSymbleLabel.text = @"¥";
        _priceSymbleLabel.textColor = [UIColor initWithHex:0xFF3B32];
    }
    return _priceSymbleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _priceLabel.textColor = [UIColor initWithHex:0xFF3B32];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

- (UILabel *)priceTagLabel{
    if (!_priceTagLabel) {
        _priceTagLabel = [UILabel new];
        _priceTagLabel.text = @"券后";
        _priceTagLabel.textColor = [UIColor initWithHex:0x9B9B9B];
        _priceTagLabel.font = [UIFont systemFontOfSize:10];
    }
    return _priceTagLabel;
}

- (UIImageView *)couponImageView{
    if (!_couponImageView) {
        _couponImageView = [UIImageView new];
        _couponImageView.image = [UIImage bundleImageNamed:@"bxk_coupon1"];
        _couponImageView.layer.cornerRadius = 2;
        _couponImageView.clipsToBounds = YES;
    }
    return _couponImageView;
}

- (UILabel *)couponLabel{
    if (!_couponLabel) {
        _couponLabel = [UILabel new];
        _couponLabel.textColor = [UIColor whiteColor];
        _couponLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    }
    return _couponLabel;
}

@end
