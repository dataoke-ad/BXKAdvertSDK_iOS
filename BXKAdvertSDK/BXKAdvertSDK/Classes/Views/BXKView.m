//
//  BXKView.m
//  BXKAdvertSDK
//
//  Created by wit on 2020/8/25.
//

#import "BXKView.h"

@implementation BXKView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initSubviews];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //[self initSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = [UIColor whiteColor];
}

@end
