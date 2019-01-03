//
//  OTCameraMaskView.m
//  OCRTool
//
//  Created by Mac on 2019/1/3.
//  Copyright © 2019年 Jaesun. All rights reserved.
//

#import "SJCameraMaskView.h"
@interface SJCameraMaskView()
/** 底部操作栏 */
@property (nonatomic, strong) UIView *toolBar;
/** 手电筒按钮 */
@property (nonatomic, strong) UIButton *trochButton;
/** 相册按钮 */
@property (nonatomic, strong) UIButton *photosButton;

@property (nonatomic, strong) UIButton *takePhotoButton;

@end

@implementation SJCameraMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置背景为clear
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    
    [self addSubview:self.toolBar];
    SJWeakSelf;
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(100.f);
    }];

    [self.toolBar addSubview:self.photosButton];
    [self.toolBar addSubview:self.takePhotoButton];
    [self.toolBar addSubview:self.trochButton];
    UIImage *photos_img = [UIImage imageNamed:@"btn_photos"];
    [self.photosButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.toolBar);
        make.left.equalTo(weakSelf.toolBar).offset(40.f);
        make.size.mas_equalTo(CGSizeMake(photos_img.size.width, 60.f));
    }];
    [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.toolBar);
    }];
    UIImage *troch_img = [UIImage imageNamed:@"btn_troch"];
    [self.trochButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.toolBar);
        make.right.equalTo(weakSelf.toolBar).offset(-40.f);
        make.size.mas_equalTo(CGSizeMake(troch_img.size.width, 60.f));
    }];
}

- (UIView *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectZero];
        _toolBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _toolBar;
}

- (UIButton *)photosButton {
    if (!_photosButton) {
        _photosButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *img = [UIImage imageNamed:@"btn_photos"];
        [_photosButton setImage:img forState:UIControlStateNormal];
        [_photosButton setTitle:@"相册" forState:UIControlStateNormal];
        _photosButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _photosButton.imageEdgeInsets = UIEdgeInsetsMake(-img.size.height, 0, 0, 0);
        _photosButton.titleEdgeInsets = UIEdgeInsetsMake(img.size.height, -img.size.width, 0, 0);
        _photosButton.imageView.contentMode = UIViewContentModeCenter;
        [_photosButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photosButton;
}

- (UIButton *)trochButton {
    if (!_trochButton) {
        _trochButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *img = [UIImage imageNamed:@"btn_troch"];
        [_trochButton setImage:img forState:UIControlStateNormal];
        _trochButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _trochButton.imageEdgeInsets =UIEdgeInsetsMake(-img.size.height, 0, 0, 0);
        _trochButton.titleEdgeInsets = UIEdgeInsetsMake(img.size.height, -img.size.width, 0, 0);
        [_trochButton setTitle:@"照亮" forState:UIControlStateNormal];
        _trochButton.imageView.contentMode = UIViewContentModeCenter;
        [_trochButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _trochButton;
}

- (UIButton *)takePhotoButton {
    if (!_takePhotoButton) {
        _takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_takePhotoButton setImage:[UIImage imageNamed:@"btn_take_photo"] forState:UIControlStateNormal];
        [_takePhotoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePhotoButton;
}

#pragma mark- Action
- (void)buttonAction:(UIButton *)sender {
    SJCameraOperationType type = SJCameraOperationTypeTorch;
    if (sender == self.photosButton) {
        type = SJCameraOperationTypePhotos;
    }
    else if(sender == self.takePhotoButton) {
        type = SJCameraOperationTypeTakePhoto;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(cameraMaskView:operationWithType:)]) {
        [self.delegate cameraMaskView:self operationWithType:type];
    }
}
@end
