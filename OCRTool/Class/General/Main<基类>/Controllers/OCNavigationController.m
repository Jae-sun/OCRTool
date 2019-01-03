//
//  OCNavigationController.m
//  Util_SJObjectiveCLibDemo
//
//  Created by Mac on 2018/12/14.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "OCNavigationController.h"

@implementation OCNavigationController
+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 只要是通过模型设置,都是通过富文本设置
    // 设置导航条标题 => UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16.f];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"71ace9"]] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage imageNamed:@"line"]];
    bar.tintColor = [UIColor whiteColor];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
    
}

@end
