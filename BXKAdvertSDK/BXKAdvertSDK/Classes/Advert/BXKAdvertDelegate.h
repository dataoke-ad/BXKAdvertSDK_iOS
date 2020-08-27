//
//  BXKAdvertDelegate.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import <Foundation/Foundation.h>
#import "BXKAdvertProtocol.h"

@protocol BXKAdvertDelegate <NSObject>

@optional
- (void)advert:(id<BXKAdvertProtocol>)advert didRequestSuccess:(NSDictionary *)response;

@optional
- (void)advert:(id<BXKAdvertProtocol>)advert didRequestFailure:(NSError *)error;

@optional
- (void)advert:(id<BXKAdvertProtocol>)advert didClickWithLandingLink:(NSString *)landingLink;

@optional
- (void)advertDidClose:(id<BXKAdvertProtocol>)advert;

@end
