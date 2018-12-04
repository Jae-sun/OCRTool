//
//  OTRecordAdModel.h
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTRecordAdModel : NSObject

/** 跟控制器 */
@property (nonatomic, strong) UIViewController *rootViewController;
/** 广告ID */
@property (nonatomic, copy) NSString *adUnitID;
@end

NS_ASSUME_NONNULL_END
