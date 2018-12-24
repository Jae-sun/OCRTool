//
//  OTHomeView.h
//  OCRTool
//
//  Created by Jae sun on 2018/11/15.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJADView.h"

@protocol OTHomeViewDelegate <UICollectionViewDelegate>

- (void)homeView:(UIView *)view clickedButton:(UIButton *)button;

@end

@interface OTHomeView : SJADView

@property (nonatomic, weak) id<OTHomeViewDelegate> delegate;
@property (nonatomic, weak) id<UICollectionViewDataSource> dataSource;

@end
