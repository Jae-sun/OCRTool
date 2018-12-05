//
//  OTResultController.h
//  OCRTool
//
//  Created by Jae sun on 2018/11/19.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTResultController : UIViewController<GADInterstitialDelegate>

/** 扫描结果 **/
@property (nonatomic, copy) id result;

/// The interstitial ad.
@property(nonatomic, strong) GADInterstitial *interstitial;

@end
