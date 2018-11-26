//
//  SJCoreDataUtil.m
//  SJTestDemo
//
//  Created by Mac on 2018/11/16.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJCoreDataUtil.h"
#import <CoreData/CoreData.h>

@interface SJCoreDataUtil()
/** CoreData配置文件文件名 */
@property (nonatomic, copy) NSString *resource;
/** 存储数据库名 */
@property (nonatomic, copy) NSString *sqliteName;

/** 数据存储管理调度器 */
@property (nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;

@end

@implementation SJCoreDataUtil

/**
 初始化数据操作工具类
 
 @param resource CoreData 配置文件
 @param sqliteName 数据存储的数据库名称
 @return 数据操作工具类
 */
- (instancetype)initWithCoreDataResource:(NSString *)resource sqliteName:(NSString *)sqliteName {
    if (self = [super init]) {
        self.resource = resource;
        self.sqliteName = sqliteName;
    }
    return self;
}

#pragma mark- Setter/Getter
- (NSManagedObjectContext *)context {
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        // 关联协调器
        _context.persistentStoreCoordinator = self.storeCoordinator;
    }
    return _context;
}

- (NSPersistentStoreCoordinator *)storeCoordinator {
    if (!_storeCoordinator) {
        // 获取CoreData文件
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.resource withExtension:@"momd"];
        if (!modelURL) {
            NSLog(@"获取模型路径失败");
            return nil;
        }
        NSManagedObjectModel *objModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        _storeCoordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objModel];
        NSError *error;
        NSURL *SQLiteURL = [self coreDataURL];
        if (!SQLiteURL) {
            NSLog(@"获取数据k存储路径失败");
            return nil;
        }
        [_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                       configuration:nil
                                                 URL:SQLiteURL
                                             options:nil
                                               error:&error];
        if (error) {
            NSLog(@"添加SQLite持久存储到解析器失败:%@",error.localizedDescription);
            return nil;
        }
    }
    return _storeCoordinator;
}

#pragma mark- Private methed
// CoreData数据库存储路径URL
- (NSURL *)coreDataURL {
    NSString *dataRootPath = NSHomeDirectory();
    NSString *fileName = [NSString stringWithFormat:@"%@.sqlite",self.sqliteName];
    NSString *dataFullPath = [dataRootPath stringByAppendingPathComponent:fileName];
    NSURL *URL = [NSURL fileURLWithPath:dataFullPath];
    return URL;
}

@end
