//
//  OTRecognitionController.m
//  OCRTool
//
//  Created by Mac on 2018/12/4.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecognitionController.h"
#import "OTResultController.h"// 识别结果

#import "OTRecognitionAdLoadView.h"

@interface OTRecognitionController () {
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}

/** <#注释#> */
@property (nonatomic, strong) OTRecognitionAdLoadView *adLoadView;

@end

@implementation OTRecognitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"识别中...";
    SJWeakSelf;
    self.navigationItem.leftBarButtonItem = [ZZJBlockBarButtonItem blockedBarButtonItemWithImage:[UIImage imageNamed:@"black_back"] eventHandler:^{
         [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self configSubviews];
    [self configCallback];
    [self generalRecognition];
}

- (void)configSubviews {
    OTRecognitionAdLoadView *adLoadView = [[OTRecognitionAdLoadView alloc] initWithController:self];
    [self.view addSubview:adLoadView];
    SJWeakSelf;
    [adLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.adLoadView = adLoadView;
}

// 通用文字识别
- (void)generalRecognition {
    NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    [[AipOcrService shardService] detectTextFromImage:self.image withOptions:options successHandler:_successHandler failHandler:_failHandler];
}

#pragma mark- other
- (void)configCallback {
    SJWeakSelf;
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"%@", result);
        if(result[@"words_result"]){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    OTResultController *VC = [[OTResultController alloc] init];
                    VC.reslut = result[@"words_result"];
                    [weakSelf.navigationController pushViewController:VC animated:YES];                  
                });
            }];
        }
    };
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"识别失败：%@",msg);
            weakSelf.title = @"识别失败";
            weakSelf.adLoadView.recognitionFailure = YES;
        }];
    };
}

@end
