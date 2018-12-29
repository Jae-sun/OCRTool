//
//  OTResultView.m
//  OCRTool
//
//  Created by Mac on 2018/12/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTResultView.h"
#import "SJInputToolBar.h"

@implementation OTResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.textView];
    SJWeakSelf;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

@end
