//
//  OTRecordModel.m
//  OCRTool
//
//  Created by Mac on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecordModel.h"

@implementation OTRecordModel

+ (OTRecordModel *)modelWithRecord:(OTRecord *)record {
    OTRecordModel *model = [[OTRecordModel alloc] init];
    model.recordID = record.recordID;
    model.type = record.type;
    model.resultTxt = record.resultTxt;
    model.resultTime = record.resultTime;
    model.imgName = record.imgName;
    return model;
}
@end
