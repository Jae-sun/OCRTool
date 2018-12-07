//
//  SJFileUtil.h
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJFileUtil : NSObject

+ (instancetype)shareInstance;

- (void)saveImage:(UIImage *)image complete:(void(^)(NSString *imgName))complete;

- (NSString *)recordImgsDir;

@end

NS_ASSUME_NONNULL_END
