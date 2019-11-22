//
//  TKUpdatePasswordVC.m
//  TokenKit
//
//  Created by easy on 2019/11/18.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKUpdatePasswordVC.h"
#import "TKHeader.h"
#import "TKBackupPswTextFiedCell.h"
#import "TKBackupTitleDetailCell.h"
#import "TKIIdentityPasswordVC.h"

@interface TKUpdatePasswordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSString *did;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray<UITableViewCell<EListViewProtocol> *> *cellArray;

@property(nonatomic,retain)TKBackupPswTextFiedCell *cell1;  //原密码
@property(nonatomic,retain)TKBackupPswTextFiedCell *cell2;  //新密码
@property(nonatomic,retain)TKBackupPswTextFiedCell *cell3;  //确认密码
@end

@implementation TKUpdatePasswordVC

- (instancetype)initWithDid:(NSString *)did password:(NSString * __nullable)pwd{
    self = [super init];
    if (self) {
        self.did = did;
        self.pwd = pwd;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.pwd.length > 0 ? @"重置身份密码" : @"修改身份密码";
    
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)commitClick{
    NSString *pwd0 = nil;
    if (self.pwd == nil) {
        pwd0 = self.cell1.textField.text;
    }else{
        pwd0 = [_pwd tk_decrypt:_did];
    }
    NSString *pwd1 = self.cell2.textField.text;
    NSString *pwd2 = self.cell3.textField.text;
    
    if (pwd0.length <= 0 || pwd1.length <= 0 || pwd2.length <= 0) {
        return [self e_showMessage:@"请填入完整信息"];
    }
    NSString *msg = [TKIIdentityPasswordVC validatePassword:pwd1 psw2:pwd2];
    if (msg != nil) {return [self e_showMessage:msg];}
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi updatePasswordWithDid:_did password:pwd0 newPassword:pwd1 handler:^(TKResultData *data) {
        if (data.success) {
            [weakSelf e_hideHud];
            [weakSelf alertMessage:[NSString stringWithFormat:@"%@成功!",self.title] actions:@[@"确定"] handler:^(NSInteger index) {
                if(weakSelf.successBlock){
                    weakSelf.successBlock(weakSelf.did);
                }
            }];
        }else{
            [weakSelf e_showMessage:data.message];
        }
    }];

}

- (void)initTableView{
    UIView *bview = [UIView token_bottom_button:self action:@selector(commitClick) title:@"确定"];
    [self.view addSubview:bview];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EWidth, EHeight-bview.height) style:(UITableViewStylePlain)];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.tableView.separatorColor = ERGBColor(0xeeeeee);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSArray<UITableViewCell<EListViewProtocol> *> *)cellArray{
    if (_cellArray == nil) {

        TKBackupPswTextFiedCell *cell1 = [[TKBackupPswTextFiedCell alloc] init];
        [cell1 updateData:@"原身份密码"];
        TKBackupPswTextFiedCell *cell2 = [[TKBackupPswTextFiedCell alloc] init];
        [cell2 updateData:@"新身份密码"];
        TKBackupPswTextFiedCell *cell3 = [[TKBackupPswTextFiedCell alloc] init];
        [cell3 updateData:@"确认身份密码"];
        
        TKBackupTitleDetailCell *cell4 = [[TKBackupTitleDetailCell alloc] initWithType:0];
        
        self.cell1 = cell1;
        self.cell2 = cell2;
        self.cell3 = cell3;
        if (self.pwd.length > 0) {
            _cellArray = @[cell2,cell3,cell4];
        }else{
            _cellArray = @[(id)cell1,cell2,cell3,cell4];
        }
    }
    return _cellArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellArray[indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cellArray[indexPath.row] e_cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:true];
}
- (void)e_didiBackClick:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:true];
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
