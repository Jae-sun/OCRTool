//
//  OTRecordCell.h
//  OCRTool
//
//  Created by Mac on 2018/12/7.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTRecordCell : UITableViewCell

/** model */
@property (nonatomic, strong) OTRecordModel *model;

@end

NS_ASSUME_NONNULL_END
