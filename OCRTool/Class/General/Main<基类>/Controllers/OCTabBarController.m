//
//  OCTabBarController.m
//  Util_SJObjectiveCLibDemo
//
//  Created by Mac on 2018/12/28.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "OCTabBarController.h"

#import "OCNavigationController.h"


@interface OCTabBarController ()

@end

@implementation OCTabBarController
+ (void)initialize {
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x333333"]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"debe7f"]} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    OCHomeController *homeVC = [[OCHomeController alloc] init];
//    [self addChildController:homeVC title:@"首页" selImage:@"tab_icon_home_sel" norImage:@"tab_icon_home_nor"];
//
//    OCMyController *myVC = [[OCMyController alloc] init];
//    [self addChildController:myVC title:@"我的" selImage:@"tab_icon_my_sel" norImage:@"tab_icon_my_nor"];
    
}

/**
 添加视图控制器
 
 @param controller    视图控制器
 @param title         控制标题
 @param selImageNmae  选中图片
 @param norImageName  默认图片
 */
- (void)addChildController:(UIViewController *)controller
             title:(NSString *)title
          selImage:(NSString *)selImageNmae
         norImage:(NSString *)norImageName {
    UIImage *selImage = [UIImage imageNamed:selImageNmae];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *noreImage = [UIImage imageNamed:norImageName];
    noreImage = [noreImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = selImage;
    controller.tabBarItem.image = noreImage;
    controller.tabBarItem.title = title;
    OCNavigationController *nav = [[OCNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
}

@end
