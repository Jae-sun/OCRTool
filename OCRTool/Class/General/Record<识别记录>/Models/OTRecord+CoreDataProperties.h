//
//  OTRecord+CoreDataProperties.h
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//
//

#import "OTRecord+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OTRecord (CoreDataProperties)

+ (NSFetchRequest<OTRecord *> *)fetchRequest;

@property (nonatomic) int32_t recordID;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, copy) NSString *imgName;
@property (nullable, nonatomic, copy) NSString *resultTxt;
@property (nonatomic) int32_t resultTime;

@end

NS_ASSUME_NONNULL_END
