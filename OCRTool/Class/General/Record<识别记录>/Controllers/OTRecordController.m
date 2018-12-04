//
//  OTRecordController.m
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "OTRecordController.h"
#import "OTRecordAdCell.h"
#import "OTRecordAdModel.h"

@interface OTRecordController ()<UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate>
/** 列表视图 */
@property (nonatomic, strong) UITableView *tableView;

/** ads */
@property (nonatomic, copy) NSArray *adIds;

@end

@implementation OTRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    SJWeakSelf;
    self.navigationItem.leftBarButtonItem = [ZZJBlockBarButtonItem blockedBarButtonItemWithImage:[UIImage imageNamed:@"black_back"] eventHandler:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self configSubviews];
}

-(void)configSubviews {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    SJWeakSelf;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OTRecordAdCell class] forCellReuseIdentifier:@"OTRecordAdCell"];
    [self.tableView registerClass:[OTRecordAdCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OTRecordAdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTRecordAdCell" forIndexPath:indexPath];
        OTRecordAdModel *model = [[OTRecordAdModel alloc] init];
        model.rootViewController = self;
        NSArray *adIds = [SJAdsUtil bannerAdIds];
        NSInteger index = indexPath.section % adIds.count;
        model.adUnitID = adIds[index];
        [cell setModel:model];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

@end
