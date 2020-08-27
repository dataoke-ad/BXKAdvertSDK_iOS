//
//  BXKSearchView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/26.
//

#import "BXKView.h"

@interface BXKSearchView : BXKView
<UITextFieldDelegate>

@property (nonatomic, strong) UILabel   *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton  *searchButton;

@end
