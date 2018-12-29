//
//  OTHomeViewModel.m
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTHomeViewModel.h"

@interface OTHomeViewModel()

@property (nonatomic, copy) NSArray *menuDatas;

@end

@implementation OTHomeViewModel

- (void)configDatas {
    NSArray *titles = @[@"文字识别",@"银行卡",@"身份证(前)",@"身份证(后)",@"驾驶证",@"历史记录"];
    NSArray *imgNames = titles;
    NSArray *colors = @[@"eb644b",@"ffc524",@"37b6c9",@"ff864f",@"98d56e",@"71ace9"];
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < 6; i ++) {
        OTHomeMenuModel *model = [[OTHomeMenuModel alloc] init];
        model.title = titles[i];
        model.imgName = imgNames[i];
        model.tinColor = colors[i];
        [tempArr addObject:model];
    }
    self.menuDatas = tempArr.copy;
}

- (OTHomeMenuModel *)modelOfItemWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < self.menuDatas.count) {
        return self.menuDatas[indexPath.item];
    }
    return nil;
}

@end
