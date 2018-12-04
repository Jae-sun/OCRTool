//
//  OTRecordAdCell.m
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "OTRecordAdCell.h"

@interface OTRecordAdCell()<GADBannerViewDelegate>
/** 广告 */
@property (nonatomic, strong) GADBannerView *bannerView;
@end

@implementation OTRecordAdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.bannerView = [[GADBannerView alloc]
                             initWithAdSize:GADAdSizeFromCGSize(
                                                                CGSizeMake(self.bounds.size.width, self.bounds.size.height))];
    [self addSubview:self.bannerView];
    SJWeakSelf;
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
   self.bannerView.delegate = self;
   
}

- (void)setModel:(OTRecordAdModel *)model {
    if (!model) return;
    _model = model;
    self.bannerView.rootViewController = model.rootViewController;
     self.bannerView.adUnitID = model.adUnitID;
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
}

#pragma mark- GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"succesfully received ad!");
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad: %@", error.localizedDescription);
}

@end
