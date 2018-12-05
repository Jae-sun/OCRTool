//
//  OTRecognitionAdLoadView.m
//  OCRTool
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecognitionAdLoadView.h"

@interface OTRecognitionAdLoadView()<GADBannerViewDelegate>

// 广告视图
@property (nonatomic, strong) GADBannerView *topBannerView;
// 广告视图
@property (nonatomic, strong) GADBannerView *bottomBannerView;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) YYAnimatedImageView *loadingView;

@end

@implementation OTRecognitionAdLoadView


- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.controller = controller;
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
     SJWeakSelf;
    self.loadingView = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"识别中.gif"]];
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.5, kScreenWidth * 0.5));
    }];
   
    self.topBannerView = [self bannerViewWithSize:CGSizeMake(80, 300)];
    [self addSubview:self.topBannerView];
    [self.topBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
    }];
    
    self.bottomBannerView = [self bannerViewWithSize:CGSizeMake(kScreenWidth, 80)];
    [self addSubview:self.bottomBannerView];
    [self.bottomBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
}

- (GADBannerView *)bannerViewWithSize:(CGSize)size {
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(size)];
    bannerView.rootViewController = self.controller;
    bannerView.delegate = self;
    bannerView.adUnitID = [SJAdsUtil randomBannerAdId];
    GADRequest *request = [GADRequest request];
    [bannerView loadRequest:request];
    return bannerView;
}

#pragma mark- GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"succesfully received ad!");
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad: %@", error.localizedDescription);
}

#pragma mark
- (void)setRecognitionFailure:(BOOL)recognitionFailure {
    _recognitionFailure = recognitionFailure;
    if (recognitionFailure) {
        self.loadingView.image = [UIImage imageNamed:@"识别失败.png"];
    }
}

@end
