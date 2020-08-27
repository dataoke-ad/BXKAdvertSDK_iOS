//
//  BXKGetCouponView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKView.h"
#import "BXKPriceView.h"

/// 立即购买
@interface BXKGetCouponView : BXKView

@property (nonatomic, strong) BXKPriceView  *priceView;
@property (nonatomic, strong) UILabel       *salesLabel;
@property (nonatomic, strong) UIView        *shadowView;
@property (nonatomic, strong) UILabel       *buyLabel;

/**
 lazy var priceView = PriceView()
 lazy var salesLabel = UILabel(
     withFont: .systemFont(ofSize: 11),
     textColor: .white
 )
 lazy var shadowView: UIView = {
     let view = UIView()
     view.backgroundColor = UIColor(white: 1, alpha: 0.96)
     view.layer.cornerRadius = 5
     view.setLayerShadow(
         color: UIColor(hex: 0xBE0000, alpha: 0.45),
         opacity: 1,
         offset: .zero,
         radius: 5
     )
     return view
 }()
 lazy var buyLabel = UILabel(
     withFont: .systemFont(ofSize: 19, weight: .medium),
     text: "立即购买",
     textColor: UIColor(hex: 0xFE3738),
     textAlignment: .center
 )

 */
@end
