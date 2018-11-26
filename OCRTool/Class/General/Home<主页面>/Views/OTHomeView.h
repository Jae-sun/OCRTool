//
//  OTHomeView.h
//  OCRTool
//
//  Created by Jae sun on 2018/11/15.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJView.h"

@interface OTHomeView : SJView

@property (nonatomic, weak) id<UICollectionViewDelegate> delegate;
@property (nonatomic, weak) id<UICollectionViewDataSource> dataSource;

@end
