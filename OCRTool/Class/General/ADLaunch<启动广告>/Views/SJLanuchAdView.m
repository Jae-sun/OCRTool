//
//  SJLanuchAdView.m
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJLanuchAdView.h"

@interface SJLanuchAdView()<GADBannerViewDelegate>

/** 广告 */
@property (nonatomic, strong) GADBannerView *bannerView;

@property (nonatomic, strong) UIButton *cutdownButton;

@end

@implementation SJLanuchAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    SJWeakSelf;
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:GADAdSizeFromCGSize(
                                                          CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))];
    [self addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(kStatusBarHeight);
    }];
    self.bannerView.delegate = self;
    
    self.cutdownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cutdownButton];
 
    [self.cutdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bannerView).offset(25.f);
        make.right.equalTo(weakSelf).offset(-20.f);
        make.size.mas_equalTo(CGSizeMake(70, 36));
    }];
    [self.cutdownButton setTitle:@"跳过" forState:UIControlStateNormal];
    self.cutdownButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    [self.cutdownButton addTarget:self action:@selector(cutdownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setController:(UIViewController *)controller {
    _controller = controller;
    self.bannerView.rootViewController = controller;
    self.bannerView.adUnitID = @"ca-app-pub-6278538217166206/8657080456";
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
    [GADMobileAds sharedInstance] ;
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"succesfully");
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad: %@", error.localizedDescription);
}

#pragma mark - Action
- (void)cutdownButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(lanuchAdView:clickedLanuchAdViewButton:)]) {
        [self.delegate lanuchAdView:self clickedLanuchAdViewButton:sender];
    }
}
@end
