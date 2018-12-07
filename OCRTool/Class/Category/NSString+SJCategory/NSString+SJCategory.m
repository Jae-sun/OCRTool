//
//  NSString+SJCategory.m
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "NSString+SJCategory.h"

@implementation NSString (SJCategory)

+ (NSString *)nowTimeTimestamp {
    NSDate *date = [NSDate date];
    NSTimeInterval tiemInterval = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", tiemInterval];
    return timeString;
}

@end
