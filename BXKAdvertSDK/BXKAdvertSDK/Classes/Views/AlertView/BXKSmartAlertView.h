//
//  BXKSmartAlertView.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/26.
//

#import "BXKView.h"

@interface BXKSmartAlertView : BXKView

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UIButton      *closeButton;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)show;
- (void)dismiss;

@end
