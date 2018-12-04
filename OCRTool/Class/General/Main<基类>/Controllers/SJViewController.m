//
//  SJViewController.m
//  OCRTool
//
//  Created by Jae sun on 2018/10/29.
//  Copyright © 2018年 Jaesun. All rights reserved.
//

#import "SJViewController.h"

@interface SJViewController ()

@end

@implementation SJViewController

#pragma mark - Life Cycle
- (instancetype)init {self = [super init]; return self;}
//- (void)dealloc {}
- (void)viewDidLoad {[super viewDidLoad];}
- (void)viewWillAppear:(BOOL)animated {[super viewWillAppear:animated];}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
#pragma mark - Delegate/DataSource
#pragma mark UITableViewDataSource
#pragma mark UITableViewDelegate
#pragma mark - IBActions
- (IBAction)submitData:(id)sender {}
#pragma mark - Public
- (void)publicMethod {}
#pragma mark - Private
- (void)privateMethod {}
#pragma mark - Property Accessors
- (void)setCustomProperty:(id)value {}
- (id)customProperty {return nil;}


@end
