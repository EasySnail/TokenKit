//
//  TKResetPasswordVC.m
//  TokenKit
//
//  Created by easy on 2019/11/15.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKResetPasswordVC.h"
#import "TKHeader.h"
#import "TKAuthenticationCodeCell.h"
#import "TKBackupTitleDetailCell.h"
#import "TKResetPasswordStepCell.h"
#import "TKUpdatePasswordVC.h"

@interface TKResetPasswordVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSString *did;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,retain)NSMutableString *password;
@property(nonatomic,retain)NSArray<NSArray<NSDictionary *> *> *dataArray;

@property(nonatomic,retain)NSArray<UITableViewCell<EListViewProtocol> *> *cellArray;
@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,retain)TKAuthenticationTextFieldCell *phoneCell; //手机号
@property(nonatomic,retain)TKAuthenticationCodeCell *codeCell;       //验证码
@property(nonatomic,retain)TKBackupTitleDetailCell *detailCell;      //描述详情
@property(nonatomic,retain)TKResetPasswordStepCell *stepCell;        //步骤


@property(nonatomic,assign)NSInteger step;
@property(nonatomic,assign)BOOL firstEncrypt;       //密码片段第一次解密

@end

@implementation TKResetPasswordVC

- (instancetype)initWithDid:(NSString *)did phone:(NSString *)phone{
    self = [super init];
    if (self) {
        self.did = did;
        self.phone = phone;
        self.password = [NSMutableString string];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置身份密码";
    
    WeakSelf
    self.view.e_contentStatusView.buttonClickHandler = ^(EContentStatus status) {
        [weakSelf request];
    };
    [self.view.e_contentStatusView makeViewForStatus:EContentStatusNetworkError handler:^(EContentStatusItemView * _Nonnull view) {
        view.label.text = @"数据异常";
        [view.button setTitle:@"重试" forState:UIControlStateNormal];
    }];
    [self request];
    
    
    // Do any additional setup after loading the view.
}
- (void)request{
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi getDecryptPasswordServiceNodeWithDid:_did handler:^(TKResultData *data) {
        [weakSelf e_hideHud];
        if (data.success) {
            weakSelf.e_contentStatusView.status = EContentStatusNormal;
            weakSelf.dataArray = data.data;
            [weakSelf initTableView];
            [weakSelf updateStep:0 firstEncrypt:true];
        }else{
            weakSelf.e_contentStatusView.status = EContentStatusNetworkError;
        }
    }];
}

- (void)updateStep:(NSInteger)step firstEncrypt:(BOOL)firstEncrypt{
    self.step = step;
    self.firstEncrypt = firstEncrypt;
    [self.stepCell updateData:[self getService] step:step];
    
}

- (void)commitClick{
    NSString *phone = self.phoneCell.textField.text;
    NSString *code = self.codeCell.textField.text;
    if (![phone validateMobile]) {[self e_showMessage:@"手机号有误"];return;}
    if (code.length <= 0) {return [self e_showMessage:@"请输入验证码"];}
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi decryptPasswordWithDid:_did phone:phone code:code param:[self getService] handler:^(TKResultData *data) {
        if (data.success) {
            [weakSelf.password appendString:data.data];
            if (weakSelf.step < 2) {
                [weakSelf.codeCell codeTimerStart:false];
                weakSelf.codeCell.textField.text = @"";
                [weakSelf updateStep:weakSelf.step+1 firstEncrypt:true];
                [weakSelf e_hideHud];
            }else{
                [weakSelf e_hideHud];
                TKUpdatePasswordVC *vc = [[TKUpdatePasswordVC alloc] initWithDid:weakSelf.did password:weakSelf.password];
                vc.successBlock = weakSelf.successBlock;
                [weakSelf.navigationController pushViewController:vc animated:true];
            }
        }else if (data.code == 200000){
            //提示
            [weakSelf e_showMessage:data.message];
            
        }else{
            //换线
            if (weakSelf.firstEncrypt) {
                [weakSelf e_showMessage:@"已换线，请重新尝试"];
                [weakSelf.codeCell codeTimerStart:false];
                weakSelf.codeCell.textField.text = @"";
                [weakSelf updateStep:weakSelf.step firstEncrypt:false];
            }else{
                [weakSelf e_showMessage:@"服务异常"];
            }
        }
    }];
}

- (void)codeClick{
    NSString *phone = self.phoneCell.textField.text;
    if (phone.length <= 0) {[self e_showMessage:@"请输入手机号"];return;}
    if (![phone validateMobile]) {[self e_showMessage:@"手机号有误"];return;}
    NSString *service = [self getService][@"url"];
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi sendServiceCodeWithService:service phone:phone handler:^(BOOL success, NSString *error) {
        if (success) {
            [weakSelf e_hideHud];
            [weakSelf.codeCell codeTimerStart:true];
            weakSelf.codeCell.textField.enabled = true;
        }else{
            [weakSelf e_showMessage:error];
        }
    }];
}

- (NSDictionary *)getService{
    NSArray *array = self.dataArray[_step];
    NSDictionary *service = _firstEncrypt ? array.firstObject : array.lastObject;
    return service;
}

- (NSArray<UITableViewCell<EListViewProtocol> *> *)cellArray{
    if (_cellArray == nil) {
        WeakSelf
        self.phoneCell = [[TKAuthenticationTextFieldCell alloc] initWithType:1];
        TKTextFieldModel *md = [TKTextFieldModel phoneModel];
        md.value = _phone;
        md.disabled = _phone.length > 0;
        [self.phoneCell updateData:md];
        
        self.codeCell = [[TKAuthenticationCodeCell alloc] initWithType:1];
        self.codeCell.autoRemove = true;
        self.codeCell.e_handler = ^(id  _Nullable data) {
            [weakSelf codeClick];
        };
        [self.codeCell updateData:[TKTextFieldModel codeModel]];
        self.codeCell.textField.textFieldDidFinishedBlock = ^(UITextField * _Nonnull textField) {
            if (textField.text.length >= 6) {
                [weakSelf commitClick];
            }
        };
        
        
        self.detailCell = [[TKBackupTitleDetailCell alloc] initWithType:1];
        self.stepCell = [[TKResetPasswordStepCell alloc] init];
        _cellArray = @[(id)_phoneCell,_detailCell,(id)_codeCell,_stepCell];
    }
    return _cellArray;
}

- (void)initTableView{
    UIView *bview = [UIView token_bottom_button:self action:@selector(commitClick) title:@"确定"];
    [self.view addSubview:bview];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EWidth, EHeight-bview.height) style:(UITableViewStylePlain)];
    _tableView.showsVerticalScrollIndicator = false;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 0.47*EWidth)];
    //headView.image = [UIImage token_image:@"token_reset_password_bg"];
    _tableView.tableHeaderView = [UIView new];
    self.tableView.separatorColor = ERGBColor(0xeeeeee);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
