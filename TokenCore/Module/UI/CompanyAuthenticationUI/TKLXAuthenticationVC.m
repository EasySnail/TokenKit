//
//  TKLXAuthenticationVC.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKLXAuthenticationVC.h"
#import "TKIIdentityPasswordVC.h"
#import "TKCompanyAuthenticationVC.h"
#import <EServiceSDK/EServiceSDK.h>
#import "TKTransferRecordVC.h"
#import "TKUpdatePasswordVC.h"

@interface TKLXAuthenticationVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *array;
@end

@implementation TKLXAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"链信认证";
    [self tableView];
    // Do any additional setup after loading the view.
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        self.array = @[@"修改身份密码",@"企业认证",@"物权转移记录"];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        _tableView.separatorColor = ERGBColor(0xf1f1f1);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TKUpdatePasswordVC *vc = [[TKUpdatePasswordVC alloc] initWithDid:_did password:nil];
        vc.successBlock = ^(id  _Nonnull data) {
            [self.navigationController popToViewController:self animated:true];
        };
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.row == 1){
        TKCompanyAuthenticationVC *vc = [[TKCompanyAuthenticationVC alloc] init];
        vc.successBlock = ^(id  _Nonnull data) {
            
        };
        vc.code = _code;
        vc.companyName = _companyName;
        vc.did = _did;
        vc.isOrg = false;
        [self.navigationController pushViewController:vc animated:true];
        
    }else if (indexPath.row == 2){
        TKTransferRecordVC *vc = [[TKTransferRecordVC alloc] init];
        vc.did = _did;
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = ERGBColor(0x374F66);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
