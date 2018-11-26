//
//  OTHomeCollectionCell.m
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTHomeCollectionCell.h"

@interface OTHomeCollectionCell()

/** 图片 **/
@property (nonatomic, strong) UIImageView *imgView;
/** 标签 **/
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation OTHomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.layer.cornerRadius = 3.f;
        self.layer.masksToBounds = YES;
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {

    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imgView.mas_bottom).offset(15.f);
    }];
 }

- (void)setModel:(OTHomeMenuModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    self.imgView.image = [UIImage imageNamed:model.imgName];
    self.titleLabel.text = model.title;
    self.backgroundColor = [UIColor colorWithHexString:model.tinColor];
}

@end
