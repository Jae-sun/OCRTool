//
//  SJShareAlertView.h
//  SJTestDemo
//
//  Created by Mac on 2018/11/23.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SJShareAlertViewDelegate <NSObject>

- (void)shareAlertView:(UIView *)alertView clickCancelButton:(UIButton *)button;
- (void)shareAlertView:(UIView *)alertView didSelectItemAtIndex:(NSInteger)index;
@end

@interface SJShareAlertView : UIView

@property (nonatomic, weak) id<SJShareAlertViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
