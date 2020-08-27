//
//  BXKCouponView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKView.h"

@interface BXKCouponView : BXKView

@property (nonatomic, strong) UIImageView   *backgroundImageView;
@property (nonatomic, strong) UILabel       *couponLabel;
@property (nonatomic, strong) UILabel       *digitLabel;

- (void)setCoupon:(CGFloat)coupon;

@end
