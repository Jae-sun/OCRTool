//
//  OTHomeView.m
//  OCRTool
//
//  Created by Jae sun on 2018/11/15.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTHomeView.h"

#import "OTHomeCollectionCell.h"

@interface OTHomeView()
/** 背景图片 */
@property (nonatomic, strong) UIImageView *backImageView;
/** collection */
@property (nonatomic, strong) UICollectionView *collectonView;
/** 历史记录按钮 **/
@property (nonatomic, strong) UIButton *historyButton;
@end

@implementation OTHomeView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        // 配置子视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
//    [super configSubviews];
    self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_back.jpg"]];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backImageView];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = kScreenWidth * 0.314;
    CGFloat height = kScreenHeight * 0.206;
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = 10.f;
    layout.minimumInteritemSpacing = 10.f;
    self.collectonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectonView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectonView];
    [self.collectonView registerClass:[OTHomeCollectionCell class] forCellWithReuseIdentifier:@"oTHomeCollectionCell"];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat top = (kScreenHeight - height * 3 - 31) * 0.5f + 20;
    CGFloat bottom = (kScreenHeight - height * 3 - 31) * 0.5f - 20;
    CGFloat left = (kScreenWidth - width * 2 - 12) * 0.5f;
    [self.collectonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(top, left, bottom, left));
    }];
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    _dataSource = dataSource;
    self.collectonView.dataSource = dataSource;
}

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    _delegate = delegate;
    self.collectonView.delegate = delegate;
}


@end
