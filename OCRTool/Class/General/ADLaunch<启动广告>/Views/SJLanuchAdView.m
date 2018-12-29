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

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UIButton *cutdownButton;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger leftSeconds;

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
    self.backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lanch"]];
    [self addSubview:_backImgView];
    self.backImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.right.equalTo(weakSelf).offset(-10.f);
        make.centerY.equalTo(weakSelf);
    }];
    GADBannerView *bannerView = [[GADBannerView alloc]
                                 initWithAdSize:GADAdSizeFromCGSize(CGSizeMake(kScreenWidth, kScreenHeight))];
    bannerView.delegate = self;
    self.bannerView = bannerView;
    [self addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
    }];
    self.bannerView.hidden = YES;
    
    self.cutdownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cutdownButton];
    [self.cutdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kStatusBarHeight + 10);
        make.right.equalTo(weakSelf).offset(-20.f);
        make.size.mas_equalTo(CGSizeMake(70, 36));
    }];
    [self.cutdownButton setTitle:@"3S" forState:UIControlStateNormal];
    self.cutdownButton.layer.cornerRadius = 5.f;
    self.cutdownButton.layer.masksToBounds = YES;
    self.cutdownButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [self.cutdownButton addTarget:self action:@selector(cutdownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cutdownButton.hidden = YES;
}
#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"succesfully");
    self.leftSeconds = 3;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    self.cutdownButton.hidden = NO;
    self.bannerView.hidden = NO;
//    self.cutdownButton.enabled = NO;
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad: %@", error.localizedDescription);
    if (self.delegate && [self.delegate respondsToSelector:@selector(finshedInLanuchAdView:)]) {
        [self.delegate finshedInLanuchAdView:self];
    }
}

#pragma mark - Action
- (void)cutdownButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(lanuchAdView:clickedLanuchAdViewButton:)]) {
        [self.delegate lanuchAdView:self clickedLanuchAdViewButton:sender];
    }
}

- (void)timerAction:(NSTimer *)sender {
    self.leftSeconds--;
    if(self.leftSeconds == 0){
        [self.timer invalidate];
        if (self.delegate && [self.delegate respondsToSelector:@selector(finshedInLanuchAdView:)]) {
            [self.delegate finshedInLanuchAdView:self];
            [self.cutdownButton setTitle:@"跳过" forState:UIControlStateNormal];
//            self.cutdownButton.enabled = YES;
        }
    }
}

#pragma mark- Setter
- (void)setLeftSeconds:(NSInteger)leftSeconds {
    _leftSeconds = leftSeconds;
    NSString *titie = [NSString stringWithFormat:@"%ldS",(long)leftSeconds];
    [self.cutdownButton setTitle:titie forState:UIControlStateNormal];
}

- (void)setController:(SJLaunchADController *)controller {
    _controller = controller;
    self.bannerView.rootViewController = controller;
    self.bannerView.adUnitID = [SJAdsUtil lanuchAdId];
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
}



@end
