//
//  UIImage+SJCategory.m
//  SJTestDemo
//
//  Created by Mac on 2018/11/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIImage+SJCategory.h"

@implementation UIImage (SJCategory)

/**
 通过颜色生成1ptx1pt的图片

 @param color 图片颜色
 @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
