//
//  OTHomeController.m
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTHomeController.h"

#import "OTRecognitionController.h" // 识别过程
#import "OTRecordController.h"      // 历史记录

#import "OTHomeView.h"
#import "OTHomeCollectionCell.h"

#import "OTHomeViewModel.h"

@interface OTHomeController ()<OTHomeViewDelegate,UICollectionViewDataSource,GADBannerViewDelegate>
/** 主视图 **/
@property (nonatomic, strong) OTHomeView *homeView;

@property (nonatomic, strong) OTHomeViewModel *viewModel;
/**  **/
@property (nonatomic, strong) UIViewController *presentedController;
@end

@implementation OTHomeController 
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"欢迎使用OCR";
    [self.viewModel configDatas];
    [self configSubviews];
}

- (void)configSubviews {
   
    self.homeView = [[OTHomeView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.homeView];
    self.homeView.delegate = self;
    self.homeView.dataSource = self;
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }]; 
}

#pragma mark- OTHomeViewDelegate/ DataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OTHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"oTHomeCollectionCell" forIndexPath:indexPath];
    [cell setModel:[self.viewModel modelOfItemWithIndexPath:indexPath]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self generalOCR];
}

- (void)homeView:(UIView *)view clickedButton:(UIButton *)button {
    OTRecordController *vc = [[OTRecordController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Action
- (void)generalOCR {
    SJWeakSelf;
    self.presentedController = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        // 在这个block里，image即为切好的图片，可自行选择如何处理
        [weakSelf.presentedController dismissViewControllerAnimated:NO completion:nil];
        OTRecognitionController *vc = [[OTRecognitionController alloc] init];
        vc.image = image;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self presentViewController:self.presentedController animated:YES completion:nil];
}

#pragma mark- setter / getter
- (OTHomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[OTHomeViewModel alloc] init];
    }
    return _viewModel;
}

@end
