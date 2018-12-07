//
//  SJFileUtil.m
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJFileUtil.h"

@implementation SJFileUtil

static SJFileUtil *util = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[SJFileUtil alloc] init];
    });
    return util;
}

- (void)saveImage:(UIImage *)image complete:(void(^)(NSString *imgName))complete {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    NSString *imgsDir = [self recordImgsDir];
    NSString *imgName = [NSString stringWithFormat:@"%@",[NSString nowTimeTimestamp]];
    NSString *imgPath = [NSString stringWithFormat:@"%@/%@",imgsDir,imgName];
    BOOL saved = [imageData writeToFile:imgPath atomically:YES];
    if (saved && complete) {
        complete(imgName);
    }    
}

- (NSString *)recordImgsDir {
    BOOL success;
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *imgsDir = [documentsDir stringByAppendingPathComponent:@"ocr_record_imgs"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断是否存在改文件夹，不存在创建
    success = [fileManager fileExistsAtPath:imgsDir];
    if(!success) {
        [fileManager createDirectoryAtPath:imgsDir withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return imgsDir;
}


@end
