//
//  OTRecordCoreDataUtil.m
//  OCRTool
//
//  Created by Mac on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecordCoreDataUtil.h"


@interface OTRecordCoreDataUtil()


@end

@implementation OTRecordCoreDataUtil

static OTRecordCoreDataUtil *util = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[OTRecordCoreDataUtil alloc] initWithCoreDataResource:@"ocr" sqliteName:@"record"];
    });
    return util;
}

- (OTRecordModel *)curRecord {
    if (!_curRecord) {
        _curRecord = [[OTRecordModel alloc] init];
    }
    return _curRecord;
}

- (void)clearCurRecord {
    _curRecord = nil;
}

- (void)saveCurRecordComplete:(void(^)(BOOL success,NSError *error))complete  {
    [self addRecords:@[self.curRecord] complete:complete];
}
/**
 增加 数据
 
 @param records 要添加的数据
 */
- (void)addRecords:(NSArray <OTRecordModel *>*)records complete:(void(^)(BOOL success,NSError *error))complete {
    if (!records || records.count == 0) {
        return;
    }
    for (OTRecordModel *record in records) {
        OTRecord *r = [NSEntityDescription insertNewObjectForEntityForName:@"OTRecord" inManagedObjectContext:self.context];
        r.imgName    = record.imgName;
        r.type       = record.type;
        r.resultTxt  = record.resultTxt;
        r.resultTime = record.resultTime;
        r.recordID   = record.recordID;
    }
    NSError *error = nil;
    BOOL savedSuccess = [self.context save:&error];
    if (complete) {
        complete(savedSuccess,error);
    }
}

/**
 根据谓词条件查询 文字识别 记录
 
 @param format 谓词条件
 @return 文字识别记录
 */
- (NSArray *)recordsWithFormat:(NSString *)format complete:(void(^)(BOOL success,NSError *error))complete {
    //1.创建一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"OTRecord"];
    if (format) {
        //  2.创建查询谓词（查询条件）
        NSPredicate *predicate = [NSPredicate predicateWithFormat:format];
        //  3.给查询请求设置谓词
        request.predicate = predicate;
    }
    // 4.查询数据
    NSError *error = nil;
    NSArray *resultArr = [self.context executeFetchRequest:request error:&error];
    if (complete) {
        complete(!error,error);
    }
    
    return resultArr;
}

/**
 获取数据表中所有数据
 
 @return record数组
 */
- (NSArray *)allRecords {
    return [self recordsWithFormat:nil complete:nil];;
}

- (void)deleteRecordWithID:(int32_t)recordID complete:(void(^)(BOOL success,NSError *error))complete  {
    NSString *format = [NSString stringWithFormat: @"recordID = %d",recordID];
    NSArray *record = [self recordsWithFormat:format complete:complete];
    [self deleteRecords:record complete:complete];
}

/**
 删除文字识别记录
 
 @param records 需要删除的文字识别记录数组
 @param complete 删除回调
 */
- (void)deleteRecords:(NSArray<OTRecord *> *)records complete:(void(^)(BOOL success,NSError *error))complete {
    for (OTRecord *record in records) {
        [self.context deleteObject:record];
    }
    NSError *error = nil;
    BOOL savedSuccess = [self.context save:&error];
    if (complete) {
        complete(savedSuccess,error);
    }
}

/**
 删除所有文字识别记录
 
 @param complete 删除回调
 */
- (void)deleteAllRecordComplete:(void(^)(BOOL success,NSError *error))complete {
    NSArray *records = [self allRecords];
    [self deleteRecords:records complete:complete];
}

- (void)updateCurReocrdComplete:(void(^)(BOOL success,NSError *error))complete {
    NSString *format = [NSString stringWithFormat:@"recordID = %d",self.curRecord.recordID];
    NSArray *record = [self recordsWithFormat:format complete:nil];
    if (record.count > 0) {
        for (OTRecord *r in record) {
            r.resultTxt = self.curRecord.resultTxt;
            r.resultTime = self.curRecord.resultTime;
        }
    }
    [self saveRecordUpdateComplete:complete];
}

/**
 更新数据
 */
- (void)saveRecordUpdateComplete:(void(^)(BOOL success,NSError *error))complete {
    NSError *error = nil;
    BOOL savedSuccess = [self.context save:&error];
    if (complete) {
        complete(savedSuccess,error);
    }
}

@end
