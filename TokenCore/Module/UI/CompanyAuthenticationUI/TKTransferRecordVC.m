//
//  TKTransferRecordVC.m
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKTransferRecordVC.h"
#import "TokenTransferRecordCell.h"
#import "TKTransferRecordModel.h"
#import "TKHeader.h"

@interface TKTransferRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray<TKTransferRecordModel *> *dataArray;
@end

@implementation TKTransferRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物权转移记录";
    self.dataArray = [NSMutableArray array];
    [self requestData];
    
    
    // Do any additional setup after loading the view.
}


- (void)requestData{
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi getGoodsHistoryWithDid:_did handler:^(TKResultData *data) {
        if (data.success) {
            NSArray *array = data.data;
            for (TokenSignatureHistoryModel *md in array) {
                for (TokenGoodsItem *smd in md.signature) {
                    [weakSelf.dataArray addObject:[[TKTransferRecordModel alloc] initWithModel:smd]];
                }
            }
            if (weakSelf.dataArray.count == 0) {
                [weakSelf e_showMessage:@"暂无数据"];
            }else{
                [weakSelf e_hideHud];
            }
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf e_showMessage:data.message];
        }
    }];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 150;
        _tableView.estimatedRowHeight = 150;
        [_tableView registerClass:[TokenTransferRecordCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TokenTransferRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateData:self.dataArray[indexPath.row]];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
