//
//  OTRecordModel.h
//  OCRTool
//
//  Created by Mac on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTRecordModel : SJModel
/**
 识别成功时的时间戳
 */
@property (nonatomic, assign) NSInteger recordID;
/** 图片路径 */
@property (nonatomic, copy) NSString *imgPath;
/** 识别的文字结果 */
@property (nonatomic, copy) NSString *resultTxt;
/** 类型 */
@property (nonatomic, assign) NSInteger type;
/** 保存识别结果的时间戳 */
@property (nonatomic, assign) NSInteger timeInterval;

@end

NS_ASSUME_NONNULL_END
