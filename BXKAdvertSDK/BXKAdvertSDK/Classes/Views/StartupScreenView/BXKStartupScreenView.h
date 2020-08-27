//
//  BXKStartupScreenView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKView.h"
#import "BXKTagView.h"
#import "BXKCouponView.h"
#import "BXKGetCouponView.h"

@interface BXKStartupScreenView : BXKView

// 活动类型使使用
@property (nonatomic, strong) UIImageView   *adImageView; // 广告大图

// 商品类型时使用
@property (nonatomic, strong) UIImageView   *goodsImageView;  //商品图
@property (nonatomic, strong) UILabel       *goodsTitleLabel;   // 商品名
@property (nonatomic, strong) BXKTagView    *tag1View;
@property (nonatomic, strong) BXKTagView    *tag2View;
@property (nonatomic, strong) BXKCouponView *couponView;
@property (nonatomic, strong) BXKGetCouponView  *getCouponView;

@property (nonatomic, strong) UIImageView   *logoImageView;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
