//
//  SJInputToolBar.m
//  OCRTool
//
//  Created by Jae sun on 2018/11/26.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJInputToolBar.h"

@interface SJInputToolBar()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation SJInputToolBar

+ (instancetype)shareInstance {
    SJInputToolBar *toolBar = [self init];
    return toolBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
