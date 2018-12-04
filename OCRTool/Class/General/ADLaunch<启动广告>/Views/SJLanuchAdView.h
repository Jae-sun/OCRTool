//
//  SJLanuchAdView.h
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SJLanuchAdViewDelegate <NSObject>

- (void)lanuchAdView:(UIView *)view clickedLanuchAdViewButton:(UIButton *)button;

@end

@interface SJLanuchAdView : UIView

@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, weak) id<SJLanuchAdViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
