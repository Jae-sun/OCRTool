//
//  SJShareAlertCell.m
//  SJTestDemo
//
//  Created by Mac on 2018/11/23.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJShareAlertCell.h"
@interface SJShareAlertCell()

/** 标志 */
@property (nonatomic, strong) UIImageView *imgView;

/** title */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SJShareAlertCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        // 配置视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
//    self.imgView.backgroundColor = [UIColor orangeColor];
    SJWeakSelf;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).offset(-10.f);
        make.height.width.mas_equalTo(60.f);
    }];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView.mas_bottom);
        make.centerX.equalTo(weakSelf.imgView);
        make.height.mas_equalTo(20);
    }];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.imgView.image = [UIImage imageNamed:title];
    self.titleLabel.text = title;
}


@end
