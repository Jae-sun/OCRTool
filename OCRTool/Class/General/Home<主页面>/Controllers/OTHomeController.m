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
#import "SJCameraController.h"

#import "OTHomeView.h"
#import "OTHomeCollectionCell.h"

#import "OTHomeViewModel.h"

@interface OTHomeController ()<OTHomeViewDelegate,UICollectionViewDataSource,GADBannerViewDelegate>
/** 主视图 **/
@property (nonatomic, strong) OTHomeView *homeView;

@property (nonatomic, strong) OTHomeViewModel *viewModel;

@property (nonatomic, strong) UIViewController *presentedController;

@end

@implementation OTHomeController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self.viewModel configDatas];
    [self configSubviews];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"欢迎使用AI文字识别" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)configSubviews {
    self.homeView = [[OTHomeView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.homeView];
    self.homeView.dataSource = self;
    self.homeView.delegate = self;
    self.homeView.adController = self;
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
    [[OTRecordCoreDataUtil shareInstance] clearCurRecord];
    OTHomeMenuModel *model = [self.viewModel modelOfItemWithIndexPath:indexPath];
    if ([model.title isEqualToString:@"文字识别"]) {
        [self generalOCR];
    }
    else if ([model.title isEqualToString:@"历史记录"]) {
        OTRecordController *vc = [[OTRecordController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([model.title isEqualToString:@"身份证(前)"]) {
        [self idcardOCROnlineFront];
    }
    else if ([model.title isEqualToString:@"身份证(后)"]) {
        [self idcardOCROnlineBack];
    }
    else if ([model.title isEqualToString:@"银行卡"]) {
        [self bankCardOCROnline];
    }
    else if ([model.title isEqualToString:@"驾驶证"]) {
        [self drivingLicenseOCR];
    }
}


#pragma mark - Action
- (void)handlerWithImg:(UIImage *)img type:(NSInteger)type {
    SJWeakSelf;
    [self.presentedController dismissViewControllerAnimated:NO completion:^{
        [[SJFileUtil shareInstance] saveImage:img complete:^(NSString * _Nonnull imgName) {
            [OTRecordCoreDataUtil shareInstance].curRecord.imgName = imgName;
            [OTRecordCoreDataUtil shareInstance].curRecord.type = type;
            OTRecognitionController *vc = [[OTRecognitionController alloc] init];
            vc.image = img;
            vc.recognitionType = type;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }];
}

// 普通文字识别
- (void)generalOCR {
    SJCameraController *vc = [[SJCameraController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//
//    SJWeakSelf;
//    self.presentedController = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
//        // 在这个block里，image即为切好的图片，可自行选择如何处理
//        [weakSelf handlerWithImg:image type:0];
//    }];
//    [self presentViewController:self.presentedController animated:YES completion:nil];
}

// 精确识别文字
- (void)generalAccurateOCR {
    SJWeakSelf;
    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [weakSelf handlerWithImg:image type:1];
    }];
    [self presentViewController:vc animated:YES completion:nil];
    self.presentedController = vc;
}

// 身份证（前）
- (void)idcardOCROnlineFront {
    SJWeakSelf;
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                                 andImageHandler:^(UIImage *image) {
                                     [weakSelf handlerWithImg:image type:2];
                                 }];

    [self presentViewController:vc animated:YES completion:nil];
    self.presentedController = vc;
}

// 身份证（后）
- (void)idcardOCROnlineBack {
    SJWeakSelf;
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack
                                 andImageHandler:^(UIImage *image) {
                                     [weakSelf handlerWithImg:image type:3];
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
     self.presentedController = vc;
}

// 银行卡
- (void)bankCardOCROnline {
    SJWeakSelf;
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard
                                 andImageHandler:^(UIImage *image) {
                                     [weakSelf handlerWithImg:image type:4];
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
    self.presentedController = vc;

}

// 驾驶证
- (void)drivingLicenseOCR {
    SJWeakSelf;
    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [weakSelf handlerWithImg:image type:5];
    }];
    [self presentViewController:vc animated:YES completion:nil];
    self.presentedController = vc;
}

#pragma mark- setter / getter
- (OTHomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[OTHomeViewModel alloc] init];
    }
    return _viewModel;
}

@end
