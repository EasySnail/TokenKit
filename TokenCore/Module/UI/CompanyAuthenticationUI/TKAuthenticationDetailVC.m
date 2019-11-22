//
//  TKAuthenticationDetailVC.m
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKAuthenticationDetailVC.h"
#import <EServiceSDK/EServiceSDK.h>
#import "TokenAuthDetailCell.h"

@interface TKAuthenticationDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray<UITableViewCell *> *array;

@end

@implementation TKAuthenticationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isExplain ? @"认证说明" : @"认证详情";
    [self tableView];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray<UITableViewCell *> *)array{
    if (_array == nil) {
        TokenAuthDetailCell *dcell = [TokenAuthDetailCell new];
        _array = _isExplain ? @[[TokenAuthExplainCell new],dcell] : @[dcell];
    }
    return _array;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<EListViewProtocol> cell = (id)self.array[indexPath.row];
    return cell.e_cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = self.array[indexPath.row];
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
