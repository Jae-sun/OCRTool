//
//  OTRecordModel.h
//  OCRTool
//
//  Created by Mac on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJModel.h"
#import "OTRecord+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN
@interface OTRecordModel : SJModel
/**
 识别成功时的时间戳
 */
@property (nonatomic, assign) int32_t recordID;
/** 图片名 */
@property (nonatomic, copy) NSString *imgName;
/** 识别的文字结果 */
@property (nonatomic, copy) NSString *resultTxt;
/** 类型 */
@property (nonatomic, assign) int16_t type;

/** 保存识别结果的时间戳 */
@property (nonatomic, assign) int32_t resultTime;

+ (OTRecordModel *)modelWithRecord:(OTRecord *)record;

@end

NS_ASSUME_NONNULL_END
