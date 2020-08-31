//
//  BXKInfoFlowView.m
//  BXKAdvertSDK
//
//  Created by CxDtreeg on 2020/8/26.
//

#import "BXKInfoFlowView.h"
#import "BXKInfoFlowModel.h"
#import "BXKInfoFlowGoodCell.h"

@interface BXKInfoFlowView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) BXKInfoFlowModel *model;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation BXKInfoFlowView


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.model = [[BXKInfoFlowModel alloc] initWithDictionary:dictionary];
        [self initialInterface];
    }
    return self;
}

- (void)initialInterface {
    if (self.model.dataType == 1) {//商品列表
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.collectionView reloadData];
    }else {//活动
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    }
    
    [self addSubview:self.iconButton];
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:self.model.appLogo]
                               forState:UIControlStateNormal
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL * imageURL) {
        self.iconButton.hidden = image == nil;
    }];
}

- (void)tapGestureHandle:(UIGestureRecognizer *)sender {
    if (self.click) {
        self.click(self.model.mallURL);
    }
}

- (void)iconButtonDidClicked:(UIButton *)sender {
    NSString *appLogoLinkUrl = self.model.appLogoLinkUrl;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appLogoLinkUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appLogoLinkUrl] options:@{} completionHandler:nil];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.goods.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BXKInfoFlowGoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BXKInfoFlowGoodCell" forIndexPath:indexPath];
    [cell setGoods:self.model.goods[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BXKGoods *good = self.model.goods[indexPath.item];
    if (self.click) {
        self.click(good.url);
    }
}

#pragma mark - Custom Accessors
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:self.tapGesture];
    }
    return _imageView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        layout.itemSize = CGSizeMake(116, 190);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BXKInfoFlowGoodCell class] forCellWithReuseIdentifier:@"BXKInfoFlowGoodCell"];
    }
    return _collectionView;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
    }
    return _tapGesture;
}


- (UIButton *)iconButton {
    if (_iconButton == nil) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.backgroundColor = [UIColor clearColor];
        _iconButton.hidden = YES;
        _iconButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_iconButton addTarget:self action:@selector(iconButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

@end
