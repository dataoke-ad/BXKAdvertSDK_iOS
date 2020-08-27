//
//  BXKSearchView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/26.
//

#import "BXKSearchView.h"

@interface BXKSearchView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation BXKSearchView

- (void)initSubviews {
    [super initSubviews];
    [self addSubview:self.label];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.searchButton];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.lessThanOrEqualTo(self);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 10, 10, 10));
        make.height.mas_equalTo(36);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(37);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right);
        make.top.bottom.right.equalTo(self.contentView);
        make.width.mas_equalTo(75);
    }];
}

#pragma mark - IBActions

- (void)searchButtonDidClicked:(UIButton *)sender {
    if (self.textField.text.length == 0) {
        return;
    }
    [self.textField resignFirstResponder];
    if (self.click) {
        self.click(self.textField.text);
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    return YES;
}

#pragma mark - Custom Accessors

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:18];
        _label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        _label.numberOfLines = 2;

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 3;
        _label.attributedText = [[NSAttributedString alloc] initWithString:@"你还在网上原价购物吗？\n限时开放查询全网隐藏优惠券功能。" attributes:@{NSParagraphStyleAttributeName: style}];
    }
    return _label;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.layer.borderWidth = 1;
        _contentView.layer.borderColor = [UIColor  colorWithRed:1 green:80/255.0 blue:1/255.0 alpha:1].CGColor;
    }
    return _contentView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.placeholder = @"搜索全网优惠券";
        _textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)searchButton {
    if (_searchButton == nil) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchButton.backgroundColor = [UIColor  colorWithRed:1 green:80/255.0 blue:1/255.0 alpha:1];
        [_searchButton addTarget:self action:@selector(searchButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

@end
