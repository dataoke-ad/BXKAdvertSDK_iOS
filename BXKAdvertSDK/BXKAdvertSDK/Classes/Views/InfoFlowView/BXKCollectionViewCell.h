//
//  BXKCollectionViewCell.h
//  BXKAdvertSDK
//
//  Created by CxDtreeg on 2020/8/26.
//

#import <UIKit/UIKit.h>

#import "BXKGoods.h"
#if __has_include(<SDWebImage/UIImageView+WebCache.h>)
#import <SDWebImage/UIImageView+WebCache.h>
#else
#import "UIImageView+WebCache.h"
#endif
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BXKCollectionViewCell : UICollectionViewCell

@end

NS_ASSUME_NONNULL_END
