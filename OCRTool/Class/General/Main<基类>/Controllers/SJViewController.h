//
//  SJViewController.h
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NavBarItemHander)(void);
@interface SJViewController : UIViewController

- (void)leftBarButtonItemWithImageName:(NSString *)imgName handler:(NavBarItemHander)handler;

@end
