//
//  OTRecordCoreDataUtil.h
//  OCRTool
//
//  Created by Mac on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJCoreDataUtil.h"
#import "OTRecordModel.h"
#import "OTRecord+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTRecordCoreDataUtil : SJCoreDataUtil

/** 当前操作的记录 */
@property (nonatomic, strong) OTRecordModel *curRecord;

+ (instancetype)shareInstance;


- (void)clearCurRecord;

- (void)saveCurRecordComplete:(void(^)(BOOL success,NSError *error))complete;

- (void)addRecords:(NSArray <OTRecordModel *>*)records complete:(void(^)(BOOL success,NSError *error))complete;

/**
 获取数据表中所有数据
 
 @return record数组
 */
- (NSArray *)allRecords;

- (void)deleteRecordWithID:(int32_t)recordID complete:(void(^)(BOOL success,NSError *error))complete;
/**
 删除文字识别记录
 
 @param records 需要删除的文字识别记录数组
 @param complete 删除回调
 */
- (void)deleteRecords:(NSArray<OTRecord *> *)records complete:(void(^)(BOOL success,NSError *error))complete;
/**
 删除所有文字识别记录
 
 @param complete 删除回调
 */
- (void)deleteAllRecordComplete:(void(^)(BOOL success,NSError *error))complete;

- (void)updateCurReocrdComplete:(void(^)(BOOL success,NSError *error))complete;
/**
 更新数据
 */
- (void)saveRecordUpdateComplete:(void(^)(BOOL success,NSError *error))complete;

@end

NS_ASSUME_NONNULL_END
