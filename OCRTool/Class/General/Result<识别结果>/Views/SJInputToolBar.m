//
//  SJInputToolBar.m
//  OCRTool
//
//  Created by Jae sun on 2018/12/5.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJInputToolBar.h"

@interface SJInputToolBar ()

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;


@end

@implementation SJInputToolBar

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.frame = CGRectMake(0, 0, SJScreenWidth, 40.f);
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftButton];
    SJWeakSelf;
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(weakSelf);
        make.width.mas_equalTo(70.f);
    }];
    [self.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10.f);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(weakSelf);
        make.width.mas_equalTo(70.f);
    }];
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
}

- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputToolBar:clickedButton:)]) {
        [self.delegate inputToolBar:self clickedButton:sender];
    }
}

@end
