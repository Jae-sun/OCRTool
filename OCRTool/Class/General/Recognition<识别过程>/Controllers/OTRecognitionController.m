//
//  OTRecognitionController.m
//  OCRTool
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecognitionController.h"
#import "OTResultController.h" // 识别结果

#import "OTRecognitionAdLoadView.h"

@interface OTRecognitionController ()<GADInterstitialDelegate> {
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}

/** 记载页面 */
@property (nonatomic, strong) OTRecognitionAdLoadView *adLoadView;

/// The interstitial ad.
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation OTRecognitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"识别中...";
    SJWeakSelf;
    self.navigationItem.leftBarButtonItem = [ZZJBlockBarButtonItem blockedBarButtonItemWithImage:[UIImage imageNamed:@"black_back"] eventHandler:^{
         [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    self.interstitial = [[GADInterstitial alloc]
                       initWithAdUnitID:[SJAdsUtil resultInterstitialAdId]];
    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
    
    [self configSubviews];
    [self configCallback];
    switch (self.recognitionType) {
            case 0:{
                [self generalOCR];
            }
            break;
            case 1:{
                [self generalAccurateOCR];
            }
            break;
            case 2:{
                [self idcardOCROnlineFront];
            }
            break;
            case 3:{
                [self idcardOCROnlineBack];
            }
            break;
            case 4:{
                [self bankCardOCROnline];
            }
            break;
            case 5:{
                [self drivingLicenseOCR];
            }
            break;
        default:
            break;
    }
}

- (void)configSubviews {
    OTRecognitionAdLoadView *adLoadView = [[OTRecognitionAdLoadView alloc] init];
    adLoadView.adController = self;
    [self.view addSubview:adLoadView];
    SJWeakSelf;
    [adLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.adLoadView = adLoadView;
}

// 通用文字识别
- (void)generalOCR {
    NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    [[AipOcrService shardService] detectTextFromImage:self.image withOptions:options successHandler:_successHandler failHandler:_failHandler];
}

// 精确识别文字
- (void)generalAccurateOCR{
    NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    [[AipOcrService shardService] detectTextAccurateFromImage:self.image
                                                      withOptions:options
                                                   successHandler:_successHandler
                                                      failHandler:_failHandler];
}

// 身份证（前）
- (void)idcardOCROnlineFront {
    [[AipOcrService shardService] detectIdCardFrontFromImage:self.image
                                                 withOptions:nil
                                              successHandler:_successHandler
                                                 failHandler:_failHandler];
}

// 身份证（后）
- (void)idcardOCROnlineBack {
    [[AipOcrService shardService] detectIdCardBackFromImage:self.image
                                                withOptions:nil
                                             successHandler:_successHandler
                                                failHandler:_failHandler];
}

// 银行卡
- (void)bankCardOCROnline {
    [[AipOcrService shardService] detectBankCardFromImage:self.image
                                           successHandler:_successHandler
                                              failHandler:_failHandler];
}

// 驾驶证
- (void)drivingLicenseOCR {
    [[AipOcrService shardService] detectDrivingLicenseFromImage:self.image
                                                    withOptions:nil
                                                 successHandler:_successHandler
                                                    failHandler:_failHandler];
}

#pragma mark- other
- (void)configCallback {
    SJWeakSelf;
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            OTResultController *resultController = [[OTResultController alloc] init];
            resultController.result = result;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController pushViewController:resultController animated:YES];
            });
        }];
    };
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"识别失败：%@",msg);
            weakSelf.title = @"识别失败";
            weakSelf.adLoadView.errorMsg = [weakSelf errorMsgWithCode:error.code];
        }];
    };
}

#pragma mark GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    if ([self.interstitial isReady] && self.recognitionType != 0) {
        [self.interstitial presentFromRootViewController:self];
    }
}

- (NSString *)errorMsgWithCode:(NSInteger)code {
    switch (code) {
        case 216015:
            return @"模块关闭";
            break;
        case 216100:
            return @"图片未发现相应内容";
            break;
        case 216101:
            return @"参数数量不够";
            break;
        case 216102:
            return @"业务不支持";
            break;
        case 216103:
            return @"参数太长";
            break;
        case 216110:
            return @"APP ID不存在";
            break;
        case 216111:
            return @"非法用户ID";
            break;
        case 216200:
            return @"空的图片";
            break;
        case 216201:
            return @"图片格式错误";
            break;
        case 216202:
            return @"图片大小错误";
            break;
        case 216401:
            return @"内部错误";
            break;
        case 216500:
            return @"未知错误";
            break;
        case 216630:
            return @"识别错误";
            break;
        case 216631:
            return @"未检测到银行卡";
            break;
        case 216633:
            return @"未检测到身份证";
            break;
        case 216634:
            return @"检测错误";
            break;
        case 216632:
            return @"未知错误";
        default:
            break;
    }
    return @"识别失败,请稍后再试";
}



@end
