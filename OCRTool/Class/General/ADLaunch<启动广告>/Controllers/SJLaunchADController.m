//
//  SJLaunchADController.m
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJLaunchADController.h"
#import "AppDelegate.h"
#import "SJLanuchAdView.h"

@interface SJLaunchADController ()<GADInterstitialDelegate,SJLanuchAdViewDelegate>
/// The interstitial ad.
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation SJLaunchADController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SJLanuchAdView *adView = [[SJLanuchAdView alloc] initWithFrame:CGRectZero];
    adView.delegate = self;
    adView.controller = self;
    [self.view addSubview:adView];
    SJWeakSelf;
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark - SJLanuchAdViewDelegate
- (void)lanuchAdView:(UIView *)view clickedLanuchAdViewButton:(UIButton *)button {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate updateRootController:YES];
}

@end
