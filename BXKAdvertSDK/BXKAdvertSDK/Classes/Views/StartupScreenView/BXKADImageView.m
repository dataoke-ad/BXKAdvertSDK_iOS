//
//  BXKADImageView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKADImageView.h"

@implementation BXKADImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubViews];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.adLabel];
    [self.adLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(29, 16));
    }];
}


#pragma mark - Custom Accessors

- (UILabel *)adLabel {
    if (_adLabel == nil) {
        _adLabel = [[UILabel alloc] init];
        _adLabel.text = @"广告";
        _adLabel.textColor = [UIColor whiteColor];
        _adLabel.font = [UIFont systemFontOfSize:9];
        _adLabel.textAlignment = NSTextAlignmentCenter;
        _adLabel.backgroundColor = [UIColor  colorWithWhite:0 alpha:0.3];
    }
    return _adLabel;
}

@end
