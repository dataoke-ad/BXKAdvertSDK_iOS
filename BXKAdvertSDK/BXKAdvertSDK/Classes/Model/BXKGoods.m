//
//  BXKGoods.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKGoods.h"
#import "UIImage+BXKCategory.h"
#import "NSString+BXKCategory.h"

@implementation BXKGoods

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.xiaoliang = [dictionary[@"xiaoliang"] floatValue];
        self.jiage = [dictionary[@"jiage"] floatValue];
        self.url = dictionary[@"url"];
        self.pic = dictionary[@"pic"];
        self.quanJine = [dictionary[@"quanJine"] floatValue];

        self.yuanjia = [dictionary[@"yuanjia"] floatValue];
        self.dtitle = dictionary[@"dtitle"];
        self.tag = dictionary[@"tag"];
        self.tag1 = dictionary[@"tag1"];
        self.isTmall = [dictionary[@"isTmall"] boolValue];
    }
    return self;
}

- (NSAttributedString *)attributedTitle {
    if (self.dtitle.length == 0) {
        return nil;
    }
    
    NSString *title = [NSString stringWithFormat:@" %@", self.dtitle];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSParagraphStyleAttributeName: style}];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    UIImage *image = self.isTmall ? [UIImage bundleImageNamed:@"bxk_titleTagTmall"]: [UIImage bundleImageNamed:@"bxk_titleTagTaobao"];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, -1, image.size.width, image.size.height);
    [attText insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    return attText;
}

- (NSAttributedString *)salesString {
    if (self.xiaoliang < 1E-5) {
        return nil;
    }
    
    NSString *saleCount = [NSString stringWithFormat:@"%.0f", self.xiaoliang];
    NSString *str = [NSString stringWithFormat:@"已售 %@件", saleCount.capitalNum];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:saleCount];
    UIColor *color = [UIColor colorWithRed:248/255.0 green:231/255.0 blue:28/255.0 alpha:1];
    [attrStr setAttributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: [UIFont systemFontOfSize:13]} range:range];
    return attrStr;
}

- (NSArray *)tags {
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (self.tag.length > 0) {
        [array addObject:self.tag];
    }
    
    if (self.tag1.length > 0) {
        [array addObject:self.tag1];
    }
    return array;
}

@end
