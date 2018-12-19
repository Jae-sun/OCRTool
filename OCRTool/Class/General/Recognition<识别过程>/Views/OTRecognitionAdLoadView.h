//
//  OTRecognitionAdLoadView.h
//  OCRTool
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTRecognitionAdLoadView : SJView

- (instancetype)initWithController:(UIViewController *)controller;

/** 识别结果 */
@property (nonatomic, copy) NSString *errorMsg;

@end

NS_ASSUME_NONNULL_END
