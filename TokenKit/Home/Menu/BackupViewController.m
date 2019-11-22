//
//  BackupViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/22.
//  Copyright © 2019 easy. All rights reserved.
//

#import "BackupViewController.h"
#import <ELibsManager/ELibsManager.h>

@interface BackupViewController ()
@property(nonatomic,retain)NSMutableArray<UITextField *> *tfs;

@property(nonatomic,retain)UILabel *resLabel;
@end

@implementation BackupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isBackup ? @"数据备份" : @"备份查询";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)comitClick{
    [self.view endEditing:true];
    NSString *dataType = self.tfs[0].text;
    NSString *dataId = self.tfs[1].text;
    NSString *data = self.tfs.lastObject.text;
    NSString *did = Account.sharedInstance.did;
    self.resLabel.text = @"";
    
    
    if (_isBackup) {
        if (dataType.length <= 0 || dataId.length <= 0 || data.length <= 0) {
            return [self e_showMessage:@"请输入完整数据"];
        }
        [self e_showHudText:@""];
        [TokenApi token_backup_dataWithDid:did dataId:dataId dataType:dataType data:data handler:^(TKResultData *res) {
            if (res.success) {
                [self e_showMessage:@"备份成功"];
            }else{
                [self e_showMessage:res.message];
            }
        }];
    }else{
        
        if (dataType.length <= 0 || dataId.length <= 0) {
            return [self e_showMessage:@"请输入完整数据"];
        }
        [self e_showHudText:@""];
        [TokenApi token_get_backup_dataWithDid:did dataId:dataId dataType:dataType handler:^(TKResultData *res) {
            if (res.success) {
                [self e_hideHud];
                self.resLabel.text = res.data;
            }else{
                [self e_showMessage:res.message];
            }
        }];
        
    }
    
}


- (void)initView{
    self.tfs = [NSMutableArray array];
    NSArray *titles = @[@"数据类型",@"数据ID",@"内容"];
    NSArray *values = @[@"test_type",@"data_id_100",@""];
    for (int i = 0; i < (_isBackup ? 3 : 2); ++i) {
        UITextField *tf = [[UITextField alloc] init];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.placeholder = titles[i];
        tf.text = values[i];
        tf.font = [UIFont systemFontOfSize:13];
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:tf];
        
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.top.mas_equalTo(120+i*50);
            make.height.mas_equalTo(35);
            make.centerX.equalTo(self.view.mas_centerX).offset(20);
        }];
        UILabel *lb = [[UILabel alloc] init];
        lb.font = [UIFont systemFontOfSize:14];
        lb.textColor = [UIColor darkTextColor];
        [self.view addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(65, 35));
            make.right.equalTo(tf.mas_left);
            make.centerY.equalTo(tf.mas_centerY);
        }];
        lb.text = titles[i];
        [self.tfs addObject:tf];
    }
   
    UIButton *bt = [UITools button:CGRectZero title:_isBackup ? @"备 份" : @"查 询"];
    [bt addTarget:self action:@selector(comitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 35));
        make.top.equalTo(self.tfs.lastObject.mas_bottom).offset(30);
    }];
    
    self.resLabel = [[UILabel alloc] init];
    _resLabel.textColor = [UIColor darkGrayColor];
    _resLabel.font = [UIFont systemFontOfSize:13];
    _resLabel.textAlignment = NSTextAlignmentCenter;
    _resLabel.numberOfLines = 0;
    [self.view addSubview:_resLabel];
    [_resLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bt.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(20);
    }];
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
