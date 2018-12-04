//
//  SJAdsUtil.m
//  SJTestDemo
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJAdsUtil.h"

@implementation SJAdsUtil

// 列表横幅广告
+ (NSArray *)bannerAdIds {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bannerAdIds" ofType:@"plist"];
    NSArray *adIds = [NSArray arrayWithContentsOfFile:path];
    return adIds;
}
// 随机横幅广告
+ (NSString *)randomBannerAdId {
    NSArray *adIds = [self bannerAdIds];
    NSInteger index = arc4random()%adIds.count;
    return adIds[index];
}
// 启动页广告
+ (NSString *)lanuchAdId {
    return @"ca-app-pub-6278538217166206/8657080456";
}
@end
