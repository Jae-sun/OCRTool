//
//  OTRecognitionController.h
//  OCRTool
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTRecognitionController : SJViewController

/** 图片 */
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) NSInteger recognitionType;

@end

NS_ASSUME_NONNULL_END
