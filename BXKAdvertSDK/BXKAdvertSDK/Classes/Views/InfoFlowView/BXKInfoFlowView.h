//
//  BXKInfoFlowView.h
//  BXKAdvertSDK
//
//  Created by CxDtreeg on 2020/8/26.
//

#import "BXKView.h"


NS_ASSUME_NONNULL_BEGIN

@interface BXKInfoFlowView : BXKView

// 活动类型使用
@property (strong, nonatomic) UIImageView *imageView;

// 商品类型使用
@property (strong, nonatomic) UICollectionView *collectionView;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
