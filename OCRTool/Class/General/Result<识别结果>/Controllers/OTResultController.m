//
//  OTResultController.m
//  OCRTool
//
//  Created by Jae sun on 2018/11/19.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTResultController.h"
#import "SJShareAlertView.h"
#import "OTResultView.h"
#import "SJInputToolBar.h"

@interface OTResultController ()<SJShareAlertViewDelegate,SJInputToolBarDelegate>

@property (nonatomic, strong) OTResultView *resultView;

@property (nonatomic, strong)  SJCustomAlertController *alertController;


@end

@implementation OTResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"识别结果";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubviews];
    [self configDatas];
}

- (void)configSubviews {
   
    SJWeakSelf;
    self.resultView = [[OTResultView alloc] initWithFrame:CGRectZero];
    self.resultView.adController = self;
    [self.view addSubview:self.resultView];
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(kHeightForNavBarAndStatusBar, 0, 0, 0));
    }];
    SJInputToolBar *toolBar = [[SJInputToolBar alloc] init];
    self.resultView.textView.inputAccessoryView = toolBar;
    toolBar.delegate = self;
    self.navigationItem.leftBarButtonItem = [ZZJBlockBarButtonItem blockedBarButtonItemWithImage:[UIImage imageNamed:@"black_back"] eventHandler:^{
        if (self.result) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.navigationItem.rightBarButtonItem = [ZZJBlockBarButtonItem blockedBarButtonItemWithImage:[UIImage imageNamed:@"分享"] eventHandler:^{
        [self.resultView resignFirstResponder];
        CGFloat height = [UIScreen mainScreen].bounds.size.width / 3.0f * 2 + 54.f;
        SJShareAlertView *alertView = [[SJShareAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
        alertView.delegate = self;
        SJCustomAlertController *alertController = [[SJCustomAlertController alloc] initWithCustomView:alertView];
        [alertController presentInController:self type:SJPresentationTypeBottom animated:YES complete:nil];
        alertController.backgroundDismissEnable = YES;
        self.alertController = alertController;
    }];
}

- (void)configDatas {
    if (self.result) {
        [self freshData];
    }
    else if(self.recordModel) {
        self.resultView.textView.text = self.recordModel.resultTxt;
        [OTRecordCoreDataUtil shareInstance].curRecord = self.recordModel;
    }
}

- (void)freshData {
    NSMutableString *message = [NSMutableString string];
    if(self.result[@"words_result"]) {
        if([self.result[@"words_result"] isKindOfClass:[NSDictionary class]]){
            [self.result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                    [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                }
                else {
                    [message appendFormat:@"%@: %@\n", key, obj];
                }
            }];
        }
        else if([self.result[@"words_result"] isKindOfClass:[NSArray class]]){
            for(NSDictionary *obj in self.result[@"words_result"]){
                if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                    [message appendFormat:@"%@\n", obj[@"words"]];
                }
                else {
                    [message appendFormat:@"%@\n", obj];
                }
            }
        }
    }
    else {
        NSDictionary *resultDic = self.result[@"result"];
        [message appendFormat:@"银行卡号：%@\n",resultDic[@"bank_card_number"]];
        [message appendFormat:@"银行名称：%@\n",resultDic[@"bank_name"]];
        [message appendFormat:@"失效日期：%@\n",resultDic[@"valid_date"]];
    }
    self.resultView.textView.text = message;
    [OTRecordCoreDataUtil shareInstance].curRecord.recordID = [NSString nowTimeTimestamp].intValue;
    [OTRecordCoreDataUtil shareInstance].curRecord.resultTime = [NSString nowTimeTimestamp].intValue;
    [OTRecordCoreDataUtil shareInstance].curRecord.resultTxt = message;
    [[OTRecordCoreDataUtil shareInstance] saveCurRecordComplete:^(BOOL success, NSError * _Nonnull error) {
        if (success) {
            NSLog(@"保存成功");
        }
        else {
            NSLog(@"保存失败：%@",error.localizedDescription);
        }
    }];
}

#pragma mark- Delegate/DataSource

#pragma mark SJShareAlertViewDelegate
- (void)shareAlertView:(UIView *)alertView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"the alert controller selected %ld",(long)index);
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
    UMSocialPlatformType type;
    switch (index) {
        case 0: {
            type = 999;
            UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:self.resultView.textView.text];
            if ([pasteboard.string isEqualToString:self.resultView.textView.text]) {
                NSLog(@"复制成功");
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"复制成功";
                hud.mode = MBProgressHUDModeText;
                hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
                [hud hideAnimated:YES afterDelay:1.5f];
            }
            return;
        }
            break;
        case 1: {
            type = UMSocialPlatformType_WechatSession;
        }
            break;
        case 2: {
            type = UMSocialPlatformType_QQ;
        }
            break;
        case 3: {
            type = UMSocialPlatformType_Sms;
        }
            break;
        case 4: {
            type = UMSocialPlatformType_WechatTimeLine;
        }
            break;
        case 5: {
            type = UMSocialPlatformType_Qzone;
        }
            break;
        default:
            type = 999;
            break;
    }
    [self shareTextToPlatformType:type];
}

- (void)shareAlertView:(UIView *)alertView clickCancelButton:(UIButton *)button {
    NSLog(@"the alert controller canceled!");
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark SJInputToolBarDelegate
- (void)inputToolBar:(UIView *)toolBar clickedButton:(UIButton *)button {
    [self.resultView.textView resignFirstResponder];
    if ([button.titleLabel.text isEqualToString:@"完成"]) {
        [OTRecordCoreDataUtil shareInstance].curRecord.resultTxt = self.resultView.textView.text;
        [OTRecordCoreDataUtil shareInstance].curRecord.resultTime = [NSString nowTimeTimestamp].intValue;
        [[OTRecordCoreDataUtil shareInstance] updateCurReocrdComplete:^(BOOL success, NSError * _Nonnull error) {
            NSLog(@"更新完成");
        }];
    }
    else if([button.titleLabel.text isEqualToString:@"取消"]) {
    }
}

#pragma mark- Private Method
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = self.resultView.textView.text;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
