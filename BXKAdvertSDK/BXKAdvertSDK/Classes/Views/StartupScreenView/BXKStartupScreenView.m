//
//  BXKStartupScreenView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKStartupScreenView.h"
#import "BXKADImageView.h"
#import "BXKGoods.h"

@interface BXKStartupScreenView ()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) BXKGoods  *goods;

@end

@implementation BXKStartupScreenView

- (instancetype)initWithDictionary:(NSDictionary *)dictionary  {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        NSString *url = self.dictionary[@"data"][@"front_img"];
        NSString *appLogo = self.dictionary[@"data"][@"appLogo"];

        NSDictionary *goods = self.dictionary[@"data"][@"list"][0];
        
        if ((![url isKindOfClass:[NSString class]] || url.length == 0) && goods.count == 0) {
            return nil;
        }
        
        [self.iconButton sd_setImageWithURL:[NSURL URLWithString:appLogo?:@""]
                                   forState:UIControlStateNormal
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL * imageURL) {
            self.iconButton.hidden = image == nil;
        }];
        
        if (goods.count > 0) {
            self.goods = [[BXKGoods alloc] initWithDictionary:goods];
            
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.goods.pic]];
            self.goodsTitleLabel.attributedText = [self.goods attributedTitle];
            
            NSArray *tags = self.goods.tags;
            
            if (tags.count == 2) {
                self.tag2View.text = tags.lastObject;
                self.tag1View.text = tags.firstObject;
            }
            
            if (tags.count == 1) {
                self.tag1View.text = tags.firstObject;
            }
            
            if (tags.count == 0) {
                self.tag1View.text = nil;
                self.tag2View.text = nil;
            }
            
            [self.couponView setCoupon:self.goods.quanJine];
            [self.getCouponView.priceView setPrice:self.goods.jiage originalPrice:self.goods.yuanjia];
            self.getCouponView.salesLabel.attributedText = self.goods.salesString;
        } else {
            [self.adImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        [self showSubviewsWithActivity:goods.count == 0];
    }
    return self;
}

- (void)initSubviews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageViewDidTap:)];
    [self addGestureRecognizer:tap];

    [self addSubview:self.adImageView];
    [self addSubview:self.goodsImageView];
    [self addSubview:self.goodsTitleLabel];
    [self addSubview:self.tag1View];
    [self addSubview:self.tag2View];
    [self addSubview:self.couponView];
    [self addSubview:self.getCouponView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.iconButton];
    
    [self.adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self.logoImageView.mas_top);
    }];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.adImageView.mas_width);
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_lessThanOrEqualTo(-10);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(10);
    }];
    
    [self.tag1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.goodsTitleLabel.mas_bottom).offset(10);
    }];
    [self.tag2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tag1View.mas_right).offset(5);
        make.top.equalTo(self.tag1View);
    }];
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.tag2View.mas_bottom).offset(10);
    }];
    
    [self.getCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(99);
        make.height.mas_equalTo(80);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

#pragma mark - IBActions

- (void)adImageViewDidTap:(UITapGestureRecognizer *)tap {
    if (self.click) {
        self.click([self landingLink]);
    }
}

- (void)iconButtonDidClicked:(UIButton *)sender {
    NSString *appLogoLinkUrl = self.dictionary[@"data"][@"appLogoLinkUrl"]?:@"http://bxk.dataoke.com/";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appLogoLinkUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appLogoLinkUrl] options:@{} completionHandler:nil];
    }
}


#pragma mark - Private

- (void)showSubviewsWithActivity:(BOOL)isActivity {
    self.adImageView.hidden = !isActivity;
    self.goodsImageView.hidden = isActivity;
    self.goodsTitleLabel.hidden = isActivity;
    self.tag1View.hidden = isActivity;
    self.tag2View.hidden = isActivity;
    self.couponView.hidden = isActivity;
    self.getCouponView.hidden = isActivity;
}

- (NSString *)landingLink {
    return self.goods.url? : self.dictionary[@"data"][@"mall_url"];
}

#pragma mark - Custom Accessors

- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        _adImageView = [[UIImageView alloc] init];
        _adImageView.userInteractionEnabled = YES;
    }
    return _adImageView;
}

- (UIImageView *)goodsImageView {
    if (_goodsImageView == nil) {
        _goodsImageView = [[BXKADImageView alloc] init];
    }
    return _goodsImageView;
}

- (UILabel *)goodsTitleLabel {
    if (_goodsTitleLabel == nil) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.font = [UIFont systemFontOfSize:15];
        _goodsTitleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }
    return _goodsTitleLabel;
}

- (BXKTagView *)tag1View {
    if (_tag1View == nil) {
        _tag1View = [[BXKTagView alloc] initWithColor:[UIColor colorWithRed:1 green:1/255.0 blue:55/255.0 alpha:1]];
        _tag1View.hidden = YES;
    }
    return _tag1View;
}

- (BXKTagView *)tag2View {
    if (_tag2View == nil) {
        _tag2View = [[BXKTagView alloc] initWithColor:[UIColor colorWithRed:1 green:81/255.0 blue:1/255.0 alpha:1]];
        _tag2View.hidden = YES;
    }
    return _tag2View;
}

- (BXKCouponView *)couponView {
    if (_couponView == nil) {
        _couponView = [[BXKCouponView alloc] init];
    }
    return _couponView;
}

- (BXKGetCouponView *)getCouponView {
    if (_getCouponView == nil) {
        _getCouponView = [[BXKGetCouponView alloc] init];
    }
    return _getCouponView;
}

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.backgroundColor = [UIColor whiteColor];
        _logoImageView.contentMode = UIViewContentModeCenter;
        _logoImageView.image = [UIImage bundleImageNamed:@"bxk_launchLogo"];
    }
    return _logoImageView;
}

- (UIButton *)iconButton {
    if (_iconButton == nil) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.backgroundColor = [UIColor clearColor];
        _iconButton.hidden = YES;
        _iconButton.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 0, 0);
        [_iconButton addTarget:self action:@selector(iconButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

@end
