//
//  SJInputToolBar.h
//  OCRTool
//
//  Created by Jae sun on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJView.h"

@protocol SJInputToolBarDelegate<NSObject>

- (void)inputToolBar:(UIView *)toolBar clickedButton:(UIButton *)button;

@end

@interface SJInputToolBar : SJView

@property (nonatomic, weak) id<SJInputToolBarDelegate> delegate;

@end
