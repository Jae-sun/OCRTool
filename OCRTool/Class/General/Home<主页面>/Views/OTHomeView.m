//
//  OTHomeView.m
//  OCRTool
//
//  Created by Jae sun on 2018/11/15.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "OTHomeView.h"

#import "OTHomeCollectionCell.h"

@interface OTHomeView()
/** 背景图片 */
@property (nonatomic, strong) UIImageView *backImageView;
/** collection */
@property (nonatomic, strong) UICollectionView *collectonView;

/** 历史记录 */
@property (nonatomic, strong) UIButton *settingButton;

@end

@implementation OTHomeView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        // 配置子视图
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
   
    self.backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_back.jpg"]];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backImageView];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = kScreenWidth * 0.314;
    CGFloat height = kScreenHeight * 0.206;
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = 10.f;
    layout.minimumInteritemSpacing = 10.f;
    self.collectonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectonView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectonView];
    [self.collectonView registerClass:[OTHomeCollectionCell class] forCellWithReuseIdentifier:@"oTHomeCollectionCell"];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat top = (kScreenHeight - height * 3 - 31) * 0.5f;
    CGFloat left = (kScreenWidth - width * 2 - 12) * 0.5f;
    [self.collectonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(top, left, top, left));
    }];
     
     [self configSettingButton];
}

- (void)configSettingButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 51.f,kScreenHeight - 76,46.f,46.f)];
    [btn setImage:[UIImage imageNamed:@"more"]  forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8.f;
    btn.layer.masksToBounds = YES;
    [self addSubview:btn];
    self.settingButton = btn;
    [self.settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // 添加手势
    UIPanGestureRecognizer *panRcognize = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panRcognize setMinimumNumberOfTouches:1];
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    [btn addGestureRecognizer:panRcognize];
}


#pragma mark- Action
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [recognizer translationInView:self];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded: {
            CGPoint stopPoint = CGPointMake(0, kScreenHeight / 2.0);
            if(recognizer.view.center.x < kScreenWidth / 2.0) {
                if(recognizer.view.center.y <= kScreenHeight/2.0) {
                    // 左上
                    if (recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.settingButton.width/2.0);
                    }
                    else {
                        stopPoint = CGPointMake(self.settingButton.width/2.0, recognizer.view.center.y);
                    }
                }
                else {
                    // 左下
                    if (recognizer.view.center.x  >= kScreenHeight - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kScreenHeight - self.settingButton.width/2.0);
                    }
                    else {
                        stopPoint = CGPointMake(self.settingButton.width/2.0, recognizer.view.center.y);
                    }
                }
            }
            else {
                if(recognizer.view.center.y <= kScreenHeight/2.0) {
                    // 右上
                    if(kScreenWidth - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.settingButton.width/2.0);
                    }
                    else {
                        stopPoint = CGPointMake(kScreenWidth - self.settingButton.width/2.0, recognizer.view.center.y);
                    }
                }
                else {
                    // 右下
                    if(kScreenWidth - recognizer.view.center.x  >= kScreenHeight - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kScreenHeight - self.settingButton.width/2.0);
                    }
                    else {
                        stopPoint = CGPointMake(kScreenWidth - self.settingButton.width/2.0,recognizer.view.center.y);
                    }
                }
            }
            //如果按钮超出屏幕边缘
            if (stopPoint.y + self.settingButton.width+40 >= kScreenHeight) {
                stopPoint = CGPointMake(stopPoint.x, kScreenHeight - self.settingButton.width/2.0 - 30);
            }
            if (stopPoint.x - self.settingButton.width/2.0 <= 0) {
                stopPoint = CGPointMake(self.settingButton.width/2.0 + 5, stopPoint.y);
            }
            if (stopPoint.x + self.settingButton.width/2.0 >= kScreenWidth) {
                stopPoint = CGPointMake(kScreenWidth - self.settingButton.width/2.0 - 5, stopPoint.y);
            }
            if (stopPoint.y - self.settingButton.width/2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, self.settingButton.width/2.0 + kStatusBarHeight);
            }
            [UIView animateWithDuration:0.3 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
        default:
            break;
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}


- (void)settingButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeView:clickedButton:)]) {
        [self.delegate homeView:self clickedButton:sender];
    }
}


- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    _dataSource = dataSource;
    self.collectonView.dataSource = dataSource;
}

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    _delegate = delegate;
    self.collectonView.delegate = delegate;
}


@end
