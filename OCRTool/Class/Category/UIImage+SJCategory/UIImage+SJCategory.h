//
//  UIImage+SJCategory.h
//  SJTestDemo
//
//  Created by Mac on 2018/11/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SJCategory)
/**
 通过颜色生成1ptx1pt的图片
 
 @param color 图片颜色
 @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
