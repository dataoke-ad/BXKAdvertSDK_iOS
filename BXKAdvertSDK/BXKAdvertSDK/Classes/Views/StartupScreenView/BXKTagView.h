//
//  BXKTagView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKView.h"

@interface BXKTagView : BXKView

@property (nonatomic, weak) NSString *text;

@property (nonatomic, strong) UILabel *label;

- (instancetype)initWithColor:(UIColor *)color;

@end
