//
//  AppDelegate.m
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "AppDelegate.h"
#import "OTHomeController.h"
#import "SJLaunchADController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-6278538217166206~9760137507"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self updateRootController:NO];
    
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:@"5bfbfc6ff1f55629480003bc" channel:@"App Store"];
    [self configUSharePlatforms];
    
    [[AipOcrService shardService] authWithAK:@"oehGlhGqfVbccSPhh5i4UpCk" andSK:@"yhQTeknEMRaet9yzXr8RBUbvAoK3HfTn"];
   
    return YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark- Public
/**
 更新根控制器
 */
- (void)updateRootController:(BOOL)showed {
    if (showed) {
        OTHomeController *homeVC = [[OTHomeController alloc] init];
        UINavigationController *rootNavC = [[UINavigationController alloc] initWithRootViewController:homeVC];
        self.window.rootViewController = rootNavC;
        [self.window makeKeyAndVisible];
    }
    else {
        SJLaunchADController *adVC = [[SJLaunchADController alloc] init];
        self.window.rootViewController = adVC;
        [self.window makeKeyAndVisible];
    }
}

#pragma mark- Private
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx995b53fcb58cbb7c" appSecret:@"86529793b01c1078756d870008e807f6" redirectURL:@"https://jaesun.oschina.io/"];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101523189"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"https://jaesun.oschina.io/"];
}
@end
