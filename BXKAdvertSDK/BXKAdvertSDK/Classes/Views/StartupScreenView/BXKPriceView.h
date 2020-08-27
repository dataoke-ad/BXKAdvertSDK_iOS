//
//  BXKPriceView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKView.h"

@interface BXKPriceView : BXKView

@property (nonatomic, strong) UILabel *symbolLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;

- (void)setPrice:(CGFloat)price originalPrice:(CGFloat)originalPrice;

@end
