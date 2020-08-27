//
//  BXKAdvertFactory.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import <Foundation/Foundation.h>
#import "BXKAdvertProtocol.h"
#import "BXKAdvertDelegate.h"

@interface BXKAdvertFactory : NSObject

+ (id<BXKAdvertProtocol>)createWithType:(BXKAdvertType)type comId:(NSString *)comId delegate:(id<BXKAdvertDelegate>)delegate;

@end
