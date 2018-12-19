//
//  OTRecordCell.m
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTRecordCell.h"

@interface OTRecordCell()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *txtLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation OTRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    SJWeakSelf;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(8.f);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    self.imgView.layer.cornerRadius = 3.f;
    self.imgView.layer.masksToBounds = YES;
    
    self.txtLabel = [[UILabel alloc] init];
    self.txtLabel.numberOfLines = 0;
    [self addSubview:self.txtLabel];
    self.txtLabel.font = [UIFont systemFontOfSize:14.f];
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView);
        make.left.equalTo(weakSelf.imgView.mas_right).offset(8.f);
        make.right.equalTo(weakSelf).offset(-8.f);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    [self addSubview:self.timeLabel];
    self.timeLabel.font = [UIFont systemFontOfSize:13.f];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.txtLabel);
        make.top.equalTo(weakSelf.txtLabel.mas_bottom).offset(8.f);
        make.bottom.equalTo(weakSelf).offset(-8.f);
        make.height.mas_equalTo(15.f);
    }];
}

- (void)setModel:(OTRecordModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *imgPath = [[[SJFileUtil shareInstance] recordImgsDir] stringByAppendingPathComponent:model.imgName];
        self.imgView.image = [UIImage imageWithContentsOfFile:imgPath];
    });
    self.txtLabel.text = model.resultTxt;
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    = model.resultTime;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    self.timeLabel.text = dateString;
}



@end
