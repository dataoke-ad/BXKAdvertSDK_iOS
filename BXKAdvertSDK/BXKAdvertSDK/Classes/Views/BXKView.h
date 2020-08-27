//
//  BXKView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import <UIKit/UIKit.h>
#import "UIImage+BXKCategory.h"

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


typedef void(^BXKViewDidClicked)(NSString *landingLink);

@interface BXKView : UIView

@property (nonatomic, copy) BXKViewDidClicked click;

/// 初始化子View
- (void)initSubviews;

@end
