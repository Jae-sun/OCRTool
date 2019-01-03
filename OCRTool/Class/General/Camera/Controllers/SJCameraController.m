//
//  SJCameraController.m
//  Util_SJObjectiveCLibDemo
//
//  Created by Mac on 2019/1/2.
//  Copyright © 2019年 S.J. All rights reserved.
//

#import "SJCameraController.h"
#import "TOCropViewController.h"
#import "OTRecognitionController.h"

#import "SJCameraMaskView.h"


@interface SJCameraController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SJCameraMaskViewDelegate,TOCropViewControllerDelegate>
// session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *captureSession;
/** 预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
// 输出图片
@property (nonatomic ,strong) AVCaptureStillImageOutput *imgOutput;

@end

@implementation SJCameraController

- (void)dealloc {
    [self.captureSession stopRunning];
    self.captureSession = nil;
    self.videoPreviewLayer = nil;
    self.imgOutput = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.5]] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SJWeakSelf;
    self.title = @"自定义相机";
    self.view.backgroundColor = [UIColor blackColor];
    
    SJCameraMaskView *maskView = [[SJCameraMaskView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:maskView];
    maskView.delegate = self;
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self configDevice];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark- SJCameraToolBarDelegate
- (void)cameraMaskView:(SJCameraMaskView *)toolBar operationWithType:(SJCameraOperationType)type {
    if(type == SJCameraOperationTypeTakePhoto) {
        [self photoButtonAction:nil];
    }
    else if(type == SJCameraOperationTypeTorch){
        [self torchAction];
    }
    else {
        [self imagePickerAction];
    }
}

#pragma mark TOCropViewControllerDelegate
- (void)cropViewController:(TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled {
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropImageToRect:(CGRect)cropRect angle:(NSInteger)angle {
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
    if (cropViewController.image) {
        [self handlerWithImg:cropViewController.image type:0];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    TOCropViewController *cropVC = [[TOCropViewController alloc] initWithImage:image];
    cropVC.delegate = self;
    [self presentViewController:cropVC animated:YES completion:nil];
}

#pragma mark- Action
- (void)photoButtonAction:(UIButton *)sender {
    AVCaptureConnection *conntion = [self.imgOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }    
    [self.imgOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        TOCropViewController *cropVC = [[TOCropViewController alloc] initWithImage:image];
        cropVC.delegate = self;
        [self presentViewController:cropVC animated:YES completion:nil];
    }];
}

- (void)torchAction {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.hasTorch) {
        [device lockForConfiguration:nil];
        AVCaptureTorchMode mode = (device.torchMode == AVCaptureTorchModeOff)?AVCaptureTorchModeOn:AVCaptureTorchModeOff;
        [device setTorchMode:mode];
        [device unlockForConfiguration];
    }
    else {
        NSLog(@"你的设备不具备手电筒功能！");
    }
}

- (void)imagePickerAction {
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imgPicker.delegate = self;
    [self presentViewController:imgPicker animated:YES completion:nil];
    imgPicker.navigationItem.rightBarButtonItem.title = @"取消";
}

#pragma mark- Private Method
// 初始化设备会话
- (void)configDevice {
    // 1.实例化捕捉会话
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPreset640x480; // 设置拿到的图像的大小
    // 2.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [self cameraWithPosition:AVCaptureDevicePositionBack];
    // 3.为会话添加输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    [self.captureSession addInput:input];
    // 4.为会话添加输出流
    self.imgOutput = [[AVCaptureStillImageOutput alloc] init];
    [self.captureSession addOutput:self.imgOutput]; // 先添加后设置属性
    
    // 5.实例化预览图层
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill]; // 设置预览图层填充方式
    [self.videoPreviewLayer setFrame:self.view.bounds];                           // 设置图层的frame
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];

    // 6.AVCaptureSession的 startRunning是阻挡主线程的一个耗时操作，所以我们放到另外的queue中操作，能够避免阻挡主线程
    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(sessionQueue, ^{
        if (self.captureSession) {
            [self.captureSession startRunning];
        }
    });
   
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
        if (device.position == position) {
            return device;
        }
    return nil;
}

- (void)handlerWithImg:(UIImage *)img type:(NSInteger)type {
    SJWeakSelf;
    [[SJFileUtil shareInstance] saveImage:img complete:^(NSString * _Nonnull imgName) {
        [OTRecordCoreDataUtil shareInstance].curRecord.imgName = imgName;
        [OTRecordCoreDataUtil shareInstance].curRecord.type = type;
        OTRecognitionController *vc = [[OTRecognitionController alloc] init];
        vc.image = img;
        vc.recognitionType = type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

@end
