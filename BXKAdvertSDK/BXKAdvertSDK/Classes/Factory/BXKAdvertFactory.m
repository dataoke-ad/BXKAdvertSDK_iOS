//
//  BXKAdvertFactory.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/24.
//

#import "BXKAdvertFactory.h"
#import "BXKAdvert.h"
#import "BXKFloaterView.h"

@implementation BXKAdvertFactory

+ (id<BXKAdvertProtocol>)createWithType:(BXKAdvertType)type comId:(NSString *)comId delegate:(id<BXKAdvertDelegate>)delegate {
    return [[BXKAdvert alloc] initWithType:type comId:comId delegate:delegate];
}

@end
