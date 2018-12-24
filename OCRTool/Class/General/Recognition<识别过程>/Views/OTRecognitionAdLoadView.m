//
//  OTRecognitionAdLoadView.m
//  OCRTool
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecognitionAdLoadView.h"

@interface OTRecognitionAdLoadView()<GADBannerViewDelegate>

@property (nonatomic, strong) YYAnimatedImageView *loadingView;

@property (nonatomic, strong) UILabel *errorLabel;

@end

@implementation OTRecognitionAdLoadView


- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    SJWeakSelf;
    self.loadingView = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"识别中.gif"]];
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.5, kScreenWidth * 0.5));
    }];
    
    self.errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loadingView.mas_bottom).offset(15.f);
        make.centerX.equalTo(weakSelf.loadingView);
    }];
    self.errorLabel.textColor = [UIColor redColor];
}

#pragma mark-
- (void)setErrorMsg:(NSString *)errorMsg {
    if (errorMsg) {
        self.loadingView.image = [UIImage imageNamed:@"识别失败.png"];
        self.errorLabel.text = errorMsg;
    }
}

@end
