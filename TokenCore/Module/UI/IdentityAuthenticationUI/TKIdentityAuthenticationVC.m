//
//  TKIdentityAuthenticationVC.m
//  TokenSDK
//
//  Created by easy on 2019/10/24.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKIdentityAuthenticationVC.h"
#import "TKAuthenticationCodeCell.h"
#import "TKIdentityImagesCell.h"
#import "TKHeader.h"


@interface TKIdentityAuthenticationVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray<id<EListViewProtocol>> *dataArray;

@end

@implementation TKIdentityAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"身份证认证";
    [self initView];
}

- (void)commitClick{
    
    NSString *name = ((TKTextFieComonCell *)self.dataArray[0]).textField.text;
    NSString *uid = ((TKTextFieComonCell *)self.dataArray[1]).textField.text;
    if (_did == nil) {
        return [self e_showMessage:@"did错误"];
    }
    if (name.length <= 0) {
        return [self e_showMessage:@"请输入姓名"];
    }
    if (![uid validateIdentity]) {
        return [self e_showMessage:@"请输入正确的身份证"];
    }
    NSArray *images = [((TKIdentityImagesCell *)self.dataArray[2]) identityImages];
    if (images.count < 3) {
        return [self e_showMessage:@"请上传图片"];
    }
    
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi authUserWithDid:_did name:name identityCode:uid identityFontImg:images[0] identityBackImg:images[1] identityHandImg:images[2] handler:^(TKResultData *rdata) {
        if (rdata.success) {
            [weakSelf e_hideHud];
            if (weakSelf.successBlock) {
                weakSelf.successBlock(rdata.data);
            }
        }else{
            [weakSelf e_showMessage:rdata.message];
        }
    }];
    
}

- (void)initView{
    
    UIView *bview = [UIView token_bottom_button:self action:@selector(commitClick) title:@"确定"];
    [self.view addSubview:bview];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EWidth, EHeight-bview.height) style:(UITableViewStyleGrouped)];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = ERGBColor(0xF1F1F1);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (id)self.dataArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArray[indexPath.row].e_cellHeight;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        TKTextFieldModel *md1 = [[TKTextFieldModel alloc] init];
        [md1 setValuesForKeysWithDictionary:@{@"title":@"姓名",@"placeholder":@"请输入你的真实姓名",
                                             @"keyboardType":@(0),@"maxLength":@(10)}];
        
        TKTextFieldModel *md2 = [[TKTextFieldModel alloc] init];
        [md2 setValuesForKeysWithDictionary:@{@"title":@"身份证号",@"placeholder":@"请输入您的身份证号",
                                             @"keyboardType":@(0),@"maxLength":@(18)}];
        TKTextFieComonCell *cell1 = [[TKTextFieComonCell alloc] init];
        TKTextFieComonCell *cell2 = [[TKTextFieComonCell alloc] init];
        [cell1 updateData:md1];
        [cell2 updateData:md2];
        
        TKIdentityImagesCell *cell3 = [[TKIdentityImagesCell alloc] init];
        
        [_dataArray addObjectsFromArray:@[(id)cell1,(id)cell2,(id)cell3]];
    }
    return _dataArray;
}
- (void)tapClick{
    [self.view endEditing:true];
}

@end
