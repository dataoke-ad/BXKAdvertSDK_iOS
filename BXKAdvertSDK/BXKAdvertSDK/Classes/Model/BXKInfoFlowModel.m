//
//  BXKInfoFlowModel.m
//  AFNetworking
//
//  Created by CxDtreeg on 2020/8/26.
//

#import "BXKInfoFlowModel.h"
#import "BXKGoods.h"

@implementation BXKInfoFlowModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.image = dictionary[@"data"][@"front_img"];
        self.mallURL = dictionary[@"data"][@"mall_url"];
        self.appLogo = dictionary[@"data"][@"appLogo"];
        self.appLogoLinkUrl = dictionary[@"data"][@"appLogoLinkUrl"]?:@"http://bxk.dataoke.com/";
        self.dataType = [dictionary[@"data"][@"data_type"] integerValue];
        self.goods = [NSMutableArray new];
        NSArray *array = dictionary[@"data"][@"list"];
        for (int i = 0; i < array.count; ++i) {
            NSDictionary *dic = array[i];
            BXKGoods *good = [[BXKGoods alloc] initWithDictionary:dic];
            [self.goods addObject:good];
        }
    }
    return self;
}

@end
