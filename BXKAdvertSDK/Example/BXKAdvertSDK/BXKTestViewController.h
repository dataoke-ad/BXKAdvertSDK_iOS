//
//  BXKTestViewController.h
//  BXKAdvertSDK_Example
//
//  Created by wit on 2020/8/26.
//  Copyright © 2020 Dataoke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BXKAdvertSDK/BXKAdvertSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BXKTestViewController : UIViewController

@property (nonatomic, strong) id<BXKAdvertProtocol> advert;

@end

NS_ASSUME_NONNULL_END
