//
//  TKIIdentityPasswordVC.m
//  TokenCard
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKIIdentityPasswordVC.h"
#import "TKBackupTitleDetailCell.h"
#import "TKBackupPswTextFiedCell.h"
#import "TKAuthenticationCodeCell.h"
#import "TKResetPasswordVC.h"

@interface TKIIdentityPasswordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)UIView *bottomView;
@property(nonatomic,copy)NSString *did;         ///< did

@property(nonatomic,retain)TKAuthenticationTextFieldCell *phoneCell; ///<手机
@property(nonatomic,retain)TKAuthenticationCodeCell *codeCell; ///<验证码

@property(nonatomic,retain)TKBackupTitleDetailCell *detailCell;///<描述详情
@property(nonatomic,retain)TKBackupTitleDetailCell *resetPwdCell;///<忘记密码
@property(nonatomic,retain)TKBackupPswTextFiedCell *cell1;  ///<原身份密码
@property(nonatomic,retain)TKBackupPswTextFiedCell *cell2;  ///<身份密码
@property(nonatomic,retain)TKBackupPswTextFiedCell *cell3;  ///<确认身份密码

@property(nonatomic,assign)NSInteger type;              ///<0=检测，1=解密，2=设置


@property(nonatomic,retain)NSArray<UITableViewCell<EListViewProtocol> *> *cellArray;
@end

@implementation TKIIdentityPasswordVC

- (void)dealloc
{
    [self.codeCell codeTimerStart:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"身份密码";
    [self cellArray];
    [self initTableView];
    [self changeType:0];
}


- (void)codeClick{
    NSString *phone = self.phoneCell.textField.text;
    if (phone.length <= 0) {[self e_showMessage:@"请输入手机号"];return;}
    if (![phone validateMobile]) {[self e_showMessage:@"手机号有误"];return;}
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi sendCodeWithPhone:phone handler:^(BOOL success, NSString *error) {
        if (success) {
            [weakSelf e_hideHud];
            [weakSelf.codeCell codeTimerStart:true];
            weakSelf.codeCell.textField.enabled = true;
        }else{
            [weakSelf e_showMessage:error];
        }
    }];
}
- (void)commitClick{
    [self.view endEditing:true];
    WeakSelf
    if (_type == 1) {
        //验证密码
        NSString *password = _cell1.textField.text;
        NSString *phone = self.phoneCell.textField.text;
        NSString *code = self.codeCell.textField.text;
        if (![phone validateMobile]) {[self e_showMessage:@"手机号有误"];return;}
        if (code.length <= 0) {[self e_showMessage:@"请输入验证码"];return;}
        if (_did.length <= 0) {[self e_showMessage:@"did为空"];return;}
        [self e_showHudText:@""];
        [TokenApi initSDKWithDid:_did phone:phone code:code password:password handler:^(TKResultData *data) {
            if (data.success) {
                [weakSelf e_hideHud];
                if (weakSelf.successBlock) {
                    weakSelf.successBlock(weakSelf.did);
                }
            }else{
                [weakSelf e_showMessage:data.message];
            }
        }];
    }else{
        NSString *password = _cell2.textField.text;
        NSString *phone = self.phoneCell.textField.text;
        NSString *code = self.codeCell.textField.text;
        if (![phone validateMobile]) {[self e_showMessage:@"手机号有误"];return;}
        if (code.length <= 0) {[self e_showMessage:@"请输入验证码"];return;}
        NSString *msg = [TKIIdentityPasswordVC validatePassword:_cell2.textField.text psw2:_cell3.textField.text];
        if (msg != nil) {[self e_showMessage:msg];return;}
        [self e_showHudText:@""];
        // 创建did
        [TokenApi createUserDidWithPassword:password code:code phone:phone handler:^(TKResultData *rdata) {
            if (rdata.success == false) {
                [weakSelf e_showMessage:rdata.message];
            }else if (weakSelf.successBlock) {
                [weakSelf e_hideHud];
                weakSelf.successBlock(rdata.data);
            }
        }];
    }
}

//验证手机号，判断did是否有效
- (void)checkedPhoneWithCode:(NSString *)code{
    if (_type != 0) {return;}
    [self.view endEditing:true];
    [self e_showHudText:@""];
    NSString *phone = self.phoneCell.textField.text;
    WeakSelf
    [TokenApi availableDidWithPhone:phone code:code handler:^(NSInteger state, NSString *msg, NSString *did) {
        if (state == 1) {
            //解密
            [weakSelf e_hideHud];
            weakSelf.did = did;
            [weakSelf changeType:1];
            weakSelf.phoneCell.textField.enabled = false;
        }else if (state == 2){
            //无did或不可用,设置新did
            [weakSelf e_hideHud];
            [weakSelf changeType:2];
            weakSelf.phoneCell.textField.enabled = false;
        }else{
            //弹出错误
            [weakSelf e_showMessage:msg];
        }
    }];
}


- (void)initTableView{
    
    UIView *bview = [UIView token_bottom_button:self action:@selector(commitClick) title:@"确定"];
    self.bottomView = bview;
    self.bottomView.hidden = true;
    [self.view addSubview:bview];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EWidth, EHeight-bview.height) style:(UITableViewStylePlain)];
    _tableView.showsVerticalScrollIndicator = false;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 15)];
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

- (void)changeType:(int)type{
    self.type = type;
    if (_type == 0) {
        self.cellArray = @[(id)_phoneCell,(id)_codeCell];
        self.bottomView.hidden = true;
        self.title = @"身份确认";
    }else if (_type == 1){
        self.cellArray = @[(id)_phoneCell,(id)_codeCell,_cell1,_resetPwdCell];
        self.bottomView.hidden = false;
        self.title = @"身份确认";
    }else if (_type == 2){
        self.cellArray = @[(id)_phoneCell,(id)_codeCell,_cell2,_cell3,_detailCell];
        self.bottomView.hidden = false;
        self.title = @"设置身份密码";
    }
    [self.tableView reloadData];
}

- (NSArray<UITableViewCell<EListViewProtocol> *> *)cellArray{
    if (_cellArray == nil) {
        _cellArray = [NSMutableArray array];
        WeakSelf
        //详细信息
        TKBackupTitleDetailCell *cell = [[TKBackupTitleDetailCell alloc] initWithType:0];
        self.detailCell = cell;
        self.resetPwdCell = [[TKBackupTitleDetailCell alloc] initWithType:10];
        _resetPwdCell.e_handler = ^(id  _Nullable data) {
            TKResetPasswordVC *vc = [[TKResetPasswordVC alloc] initWithDid:weakSelf.did phone:weakSelf.phoneCell.textField.text];
            vc.successBlock = weakSelf.successBlock;
            [weakSelf.view endEditing:true];
            [weakSelf.navigationController pushViewController:vc animated:true];
        };
        self.phoneCell = [[TKAuthenticationTextFieldCell alloc] initWithType:1];
        TKTextFieldModel *phoneModel = [[TKTextFieldModel alloc] init];
        [phoneModel setValuesForKeysWithDictionary:@{@"title":@"手机号",@"placeholder":@"请输入您的手机号",
                                                     @"keyboardType":@(1),@"maxLength":@(11)}];
        [_phoneCell updateData:phoneModel];
        
        self.codeCell = [[TKAuthenticationCodeCell alloc] initWithType:1];
        
        _codeCell.e_handler = ^(id  _Nullable data) {
            [weakSelf codeClick];
        };
        _codeCell.textField.textFieldDidChangeBlock = ^(UITextField *textField) {
            if (textField.text.length == 6) {
                [weakSelf checkedPhoneWithCode:textField.text];
            }
        };
        TKTextFieldModel *codeModel = [[TKTextFieldModel alloc] init];
        [codeModel setValuesForKeysWithDictionary:@{@"title":@"验证码",@"placeholder":@"请输入验证码",
                                                    @"keyboardType":@(1),@"maxLength":@(6)}];
        codeModel.disabled = true;
        [_codeCell updateData:codeModel];
        
        
        self.cell1 = [[TKBackupPswTextFiedCell alloc] init];
        [_cell1 updateData:@"身份密码"];
        
        self.cell2 = [[TKBackupPswTextFiedCell alloc] init];
        [_cell2 updateData:@"设置身份密码"];
        
        self.cell3 = [[TKBackupPswTextFiedCell alloc] init];
        [_cell3 updateData:@"确认身份密码"];
    }
    return _cellArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

+ (NSString *)validatePassword:(NSString *)psw psw2:(NSString *)psw2{
    if (psw.length == 0) {
        return @"请输入身份密码";
    }
    if (![psw isEqualToString:psw2]) {
        return @"两次密码不一致";
    }
    if (psw.length < 6 || psw.length > 20) {
        return @"密码长度为6-20位";
    }
    return nil;
}



#pragma mark - 监听键盘

- (void)keyboardWillShow:(NSNotification *)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    CGFloat dy = [self.tableView convertPoint:CGPointMake(0, _tableView.height) toView:[UIApplication sharedApplication].keyWindow].y;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight - (EHeight-dy), 0);
}

- (void)keyboardWillHidden:(NSNotification *)notification{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    if (parent == nil) {
        [self removeKeyboardObserver];
    }else{
        [self addKeyboardObserver];
    }
}

- (void)addKeyboardObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeKeyboardObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

