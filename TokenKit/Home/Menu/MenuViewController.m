//
//  MenuViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "MenuViewController.h"
#import "BackupViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray<NSArray *> *array;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        _tableView.backgroundColor = [UIColor colorWithWhite:0xf7/255.0 alpha:1];
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = 44;
        _tableView.sectionFooterHeight = 1;
        _tableView.sectionHeaderHeight = 10;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray<NSArray *> *)array{
    if (_array == nil) {
        _array = @[
                    @[@{@"title":@"身份认证",@"type":@"0"}],
                    @[@{@"title":@"认证详情",@"type":@"1"},@{@"title":@"认证说明",@"type":@"2"}],
                    @[@{@"title":@"确认发货",@"type":@"3"},@{@"title":@"确认收货",@"type":@"4"}],
                    @[@{@"title":@"备份数据",@"type":@"5"},@{@"title":@"查询备份",@"type":@"6"}],
                   ];
    }
    return _array;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int type = ((NSString *)(_array[indexPath.section][indexPath.row][@"type"])).intValue;
    NSString *did = Account.sharedInstance.did;
    switch (type) {
        case 0:{
            //身份认证
            [TokenUIApi open_identityAuthenticationVCWithDid:did from:self handler:^(NSString *hash) {
                //成功
                NSLog(@"%@",hash);
            }];
        }break;
        case 1:{
            //认证说明
            [TokenUIApi open_certificationDetailVCWithDid:did isExplain:true from:self];
        }break;
        case 2:{
            //认证详情
            [TokenUIApi open_certificationDetailVCWithDid:did isExplain:false from:self];
        }break;
        case 3:{
            //发货
            UIViewController *vc = [NSClassFromString(@"DeliveryViewController") new];
            vc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:vc animated:true];
        }break;
        case 4:{
            //收货
            UIViewController *vc = [NSClassFromString(@"ReceiveViewController") new];
            vc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:vc animated:true];
        }break;
        case 5:{
            //备份
            BackupViewController *vc = [[BackupViewController alloc] init];
            vc.isBackup = true;
            vc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:vc animated:true];
        }break;
        case 6:{
            //查询备份
            BackupViewController *vc = [[BackupViewController alloc] init];
            vc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:vc animated:true];
        }break;
        case 7:{
        }break;
        case 8:{
        }break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.array[indexPath.section][indexPath.row][@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
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
