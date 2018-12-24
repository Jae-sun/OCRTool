//
//  SJADView.m
//  OCRTool
//
//  Created by Mac on 2018/12/24.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJADView.h"
@interface SJADView() <GADBannerViewDelegate>

// 广告视图
@property (nonatomic, strong) GADBannerView *adView;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation SJADView

- (instancetype)init {
    if (self = [super init]) {
        [self configSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.adView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(CGSizeMake(kScreenWidth, kScreenHeight))];
    [self addSubview:self.adView];
    SJWeakSelf;
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    self.maskView = [[UIView alloc] init];
    [self addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    self.maskView.backgroundColor = [UIColor whiteColor];
}

- (void)setAdController:(UIViewController *)adController {
    _adController = adController;
    self.adView.rootViewController = adController;
    self.adView.delegate = self;
    self.adView.adUnitID = [SJAdsUtil randomBannerAdId];
    GADRequest *request = [GADRequest request];
    [self.adView loadRequest:request];
}


#pragma mark- GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"succesfully received ad!");
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad: %@", error.localizedDescription);
}

@end
