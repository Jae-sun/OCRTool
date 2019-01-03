//
//  OTCameraMaskView.h
//  OCRTool
//
//  Created by Mac on 2019/1/3.
//  Copyright © 2019年 Jaesun. All rights reserved.
//

#import "SJView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, SJCameraOperationType) {
    SJCameraOperationTypePhotos,      // 相册
    SJCameraOperationTypeTorch,       // 手电筒
    SJCameraOperationTypeTakePhoto,   // 拍照
};
@class SJCameraMaskView;
@protocol SJCameraMaskViewDelegate <NSObject>

@optional;
- (void)cameraMaskView:(SJCameraMaskView *)toolBar operationWithType:(SJCameraOperationType)type;

@end

@interface SJCameraMaskView : SJView

@property (nonatomic, weak) id<SJCameraMaskViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
