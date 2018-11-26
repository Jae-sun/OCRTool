//
//  OTHomeViewModel.h
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJViewModel.h"
#import "OTHomeMenuModel.h"

@interface OTHomeViewModel : SJViewModel

- (void)configDatas;

- (OTHomeMenuModel *)modelOfItemWithIndexPath:(NSIndexPath *)indexPath;

@end
