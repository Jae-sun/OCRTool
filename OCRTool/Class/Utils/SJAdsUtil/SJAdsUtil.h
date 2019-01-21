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
// 横幅广告
+ (NSString *)bannerAdID;
// 启动页广告
+ (NSString *)lanuchAdId;
// 识别结果页插屏广告
+ (NSString *)resultInterstitialAdId;
// 应用内通用广告
+ (NSString *)commonAdId;

@end

NS_ASSUME_NONNULL_END
