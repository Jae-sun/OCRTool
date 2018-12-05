//
//  SJAdsUtil.h
//  SJTestDemo
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJAdsUtil : NSObject

// 获取所有横幅广告的id
+ (NSArray *)bannerAdIds;
// 随机横幅广告
+ (NSString *)randomBannerAdId;

// 启动页广告
+ (NSString *)lanuchAdId;

// 识别结果页插屏广告
+ (NSString *)resultInterstitialAdId;

@end

NS_ASSUME_NONNULL_END
