//
//  SJCoreDataUtil.h
//  SJTestDemo
//
//  Created by Jaesun on 2018/11/16.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJCoreDataUtil : NSObject
/** 对象管理上下文 */
@property (nonatomic, strong) NSManagedObjectContext *context;

/**
 初始化数据操作工具类

 @param resource CoreData 配置文件
 @param sqliteName 数据存储的数据库名称
 @return 数据操作工具类
 */
- (instancetype)initWithCoreDataResource:(NSString *)resource sqliteName:(NSString *)sqliteName;

@end

NS_ASSUME_NONNULL_END
