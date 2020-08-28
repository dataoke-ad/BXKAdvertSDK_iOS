//
//  BXKGoods.h
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BXKGoods : NSObject

@property (nonatomic, assign) CGFloat xiaoliang;
@property (nonatomic, assign) CGFloat jiage;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) CGFloat quanJine;
@property (nonatomic, assign) CGFloat yuanjia;
@property (nonatomic, copy) NSString *dtitle;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *tag1;
@property (nonatomic, assign) BOOL isTmall;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSAttributedString *)attributedTitle;
- (NSArray *)tags;
- (NSAttributedString *)salesString;

@end
