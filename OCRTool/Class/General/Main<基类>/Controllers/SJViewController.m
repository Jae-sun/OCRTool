//
//  SJViewController.m
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJViewController.h"

@interface SJViewController ()

@property (nonatomic, copy) NavBarItemHander leftBarItemHanlder;
@property (nonatomic, copy) NavBarItemHander rightBarItemHanlder;

@end

@implementation SJViewController

#pragma mark - Life Cycle
- (instancetype)init {self = [super init]; return self;}
//- (void)dealloc {}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftBarButtonItemWithImageName:@"white_back" handler:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"1a98fc"]] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
#pragma mark - Delegate/DataSource
#pragma mark UITableViewDataSource
#pragma mark UITableViewDelegate
#pragma mark - IBActions
- (IBAction)submitData:(id)sender {}
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender {
    if (self.leftBarItemHanlder) {
        self.leftBarItemHanlder();
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Public
- (void)publicMethod {}
- (void)leftBarButtonItemWithImageName:(NSString *)imgName handler:(NavBarItemHander)handler {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imgName] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    self.leftBarItemHanlder = handler;
}

#pragma mark - Private
- (void)privateMethod {}
#pragma mark - Property Accessors
- (void)setCustomProperty:(id)value {}
- (id)customProperty {return nil;}


@end
