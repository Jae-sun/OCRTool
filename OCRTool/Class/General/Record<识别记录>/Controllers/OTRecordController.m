//
//  OTRecordController.m
//  SJTestDemo
//
//  Created by Mac on 2018/12/3.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "OTRecordController.h"
#import "OTResultController.h"

#import "OTRecordAdCell.h"
#import "OTRecordCell.h"
#import "OTRecordAdModel.h"

@interface OTRecordController ()<UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,GADInterstitialDelegate>
/** 列表视图 */
@property (nonatomic, strong) UITableView *tableView;

/** ads */
@property (nonatomic, copy) NSArray *adIds;

/// The interstitial ad.
@property(nonatomic, strong) GADInterstitial *interstitial;

@property (nonatomic, copy) NSArray *datas;

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
    [self configDatas];
    [self refreshAD];
}

- (void)refreshAD {
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:[SJAdsUtil resultInterstitialAdId]];
    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
}

- (void)configSubviews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    SJWeakSelf;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[OTRecordAdCell class] forCellReuseIdentifier:@"OTRecordAdCell"];
    [self.tableView registerClass:[OTRecordCell class] forCellReuseIdentifier:@"OTRecordCell"];
    
}

- (void)configDatas {
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *records = [[OTRecordCoreDataUtil shareInstance] allRecords];
    NSInteger count = records.count/4 + 1;
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:records];
    for (int i = 0; i < count; i ++) {
        [resultArr addObject:[[OTRecordModel alloc] init]];
        if (tempArr.count >= 4) {
            NSArray *subArr = [tempArr subarrayWithRange:NSMakeRange(0, 4)];
            [resultArr addObjectsFromArray:subArr];
            [tempArr removeObjectsInArray:subArr];
        }
    }
    [resultArr addObjectsFromArray:tempArr];
    self.datas = resultArr.copy;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTRecordModel *model = self.datas[indexPath.row];
    if (model.recordID) {
        OTRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTRecordCell" forIndexPath:indexPath];
        OTRecord *record = self.datas[indexPath.row];
        OTRecordModel *model = [OTRecordModel modelWithRecord:record];
        [cell setModel:model];
        return cell;
    }
    else {
        OTRecordAdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTRecordAdCell" forIndexPath:indexPath];
        OTRecordAdModel *model = [[OTRecordAdModel alloc] init];
        model.rootViewController = self;
        NSArray *adIds = [SJAdsUtil bannerAdIds];
        NSInteger index = indexPath.section % adIds.count;
        model.adUnitID = adIds[index];
        [cell setModel:model];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     OTRecordModel *model = self.datas[indexPath.row];
    if (model.recordID) {
        if ([self.interstitial isReady]) {
            [self.interstitial presentFromRootViewController:self];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            OTResultController *vc = [[OTResultController alloc] init];
            vc.recordModel = model;
            [self.navigationController pushViewController:vc animated:YES];
             [self refreshAD];
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    OTRecordModel *model = self.datas[indexPath.row];
    return model.recordID;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTRecordModel *model = self.datas[indexPath.row];
    if (model.recordID) {
        UITableViewRowAction *layTopRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"删除");
                [[OTRecordCoreDataUtil shareInstance] deleteRecordWithID:model.recordID complete:^(BOOL success, NSError * _Nonnull error) {
                    [self configDatas];
                    [self.tableView reloadData];
                }];
            }];
        NSArray *arr = @[layTopRowAction];
        return arr;
    }
    return @[];
}

#pragma mark GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
}

@end
