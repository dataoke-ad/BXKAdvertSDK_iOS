//
//  BXKInfoFlowModel.h
//  AFNetworking
//
//  Created by CxDtreeg on 2020/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BXKInfoFlowModel : NSObject

// 显示的图片url
@property (strong, nonatomic) NSString *image;
// 店铺url
@property (strong, nonatomic) NSString *mallURL;
// 商品列表
@property (strong, nonatomic) NSMutableArray *goods;
// 数据类型1-商品列表 2-活动
@property (assign, nonatomic) NSInteger dataType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
