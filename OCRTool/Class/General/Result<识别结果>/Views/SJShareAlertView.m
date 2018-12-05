//
//  SJShareAlertView.m
//  SJTestDemo
//
//  Created by Mac on 2018/11/23.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJShareAlertView.h"
#import "SJShareAlertCell.h"

@interface SJShareAlertView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** title  */
@property (nonatomic, strong) UILabel *titleLabel;
/** share items view*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** bottom confirm button */
@property (nonatomic, strong) UIButton *bottomButton;
/**
 图片名称数组
 */
@property (nonatomic, copy) NSArray *collectionDatas;

@end

@implementation SJShareAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        // 初始化数据
        [self configDatas];
        // 配置子视图
        [self configSubviews];
    }
    return self;
}

// 配置子视图
- (void)configSubviews {
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    // 分享项目
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width)/3.f;
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.itemSize = CGSizeMake(width, width);
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.collectionView registerClass:[SJShareAlertCell class] forCellWithReuseIdentifier:@"sJShareAlertCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    // 底部按钮
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.bottomButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.bottomButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomButton];
    [self.bottomButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // 布局
    [self makeConstraintsSubviews];
}

- (void)configDatas {
     self.collectionDatas = @[@"复制",@"微信",@"QQ",@"短信",@"微信朋友圈",@"QQ空间"];
//   self.collectionDatas = @[@"QQ",@"QQ",@"QQ",@"QQ",@"QQ",@"QQ"];
}

 // 子视图布局
- (void)makeConstraintsSubviews {
    SJWeakSelf;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(10.f);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.bottomButton.mas_top);
    }];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.mas_equalTo(44.f);
    }];
}

#pragma mark- UICollectionViewDelegate,UICollectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SJShareAlertCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sJShareAlertCell" forIndexPath:indexPath];
    cell.title = self.collectionDatas[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDatas.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareAlertView:didSelectItemAtIndex:)]) {
        [self.delegate shareAlertView:self didSelectItemAtIndex:indexPath.item];
    }
}

#pragma mark- Action
- (void)bottomButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareAlertView:clickCancelButton:)]) {
        [self.delegate shareAlertView:self clickCancelButton:sender];
    }
}

@end
