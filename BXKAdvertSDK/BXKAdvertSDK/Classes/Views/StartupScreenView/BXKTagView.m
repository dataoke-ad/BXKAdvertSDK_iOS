//
//  BXKTagView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKTagView.h"

@implementation BXKTagView

- (instancetype)initWithColor:(UIColor *)color {
    self = [super init];
    if (self) {
        [self addSubview:self.label];
        self.label.textColor = color;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 2;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = color.CGColor;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 4, 0, 4));
        }];

        [self.label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

#pragma mark - Public

#pragma mark - Custom Accessors

- (NSString *)text {
    return self.label.text;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
    self.hidden = text.length == 0;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:10];
    }
    return _label;
}

@end
