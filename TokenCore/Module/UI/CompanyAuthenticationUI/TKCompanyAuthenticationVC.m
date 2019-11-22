//
//  TKCompanyAuthenticationVC.m
//  TokenSDK
//
//  Created by easy on 2019/10/28.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKCompanyAuthenticationVC.h"
#import "TKAuthenticationCodeCell.h"
#import "TokenCompanyCell.h"

@interface TKCompanyAuthenticationVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray<id<EListViewProtocol>> *dataArray;
@property(nonatomic,retain)NSMutableDictionary<NSString *,id<EListViewProtocol>> *cellDict;

@property(nonatomic,copy)NSString *identityCode;
@property(nonatomic,assign)NSInteger selectTag;
@end

@implementation TKCompanyAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isOrg? @"组织认证" : @"企业认证";
    self.view.backgroundColor = [UIColor whiteColor];
    WeakSelf
    [self e_showHudText:@""];
    [TokenApi getUserAuthInfoWithDid:_did handler:^(TKResultData *rdata) {
        if (!rdata.success) {
            if (rdata.code == 2) {
                [weakSelf e_hideHud];
                [weakSelf alertMessage:@"未实名认证，请先实名认证"];
            }else{
                [weakSelf e_showMessage:rdata.message];
            }
        }else{
            [weakSelf e_hideHud];
            weakSelf.name = rdata.data[@"name"];
            weakSelf.identityCode = rdata.data[@"identityCode"];
            [weakSelf initView];
        }
    }];
}

- (void)commitClick{
    [self.view endEditing:true];
    self.code = ((TKTextFieComonCell *)self.cellDict[@"codeC"]).model.v_value;
    self.name = ((TKTextFieComonCell *)self.cellDict[@"nameC"]).model.v_value;
    UIImage *image = _selectTag == 0 ? ((TokenCompanyBusinessLicenseCell *)self.cellDict[@"licenseC"]).image :((TokenCompanyLetterCell *)self.cellDict[@"letterC"]).image;
    
    if (image == nil) {
        return [self e_showMessage:@"请选择图片"];
    }
    if (_name.length <= 0) {
        return [self e_showMessage:@"请输入法定代表人"];
    }
    if (_selectTag == 0 && _code.length <= 0) {
        return [self e_showMessage:@"请输入信用代码"];
    }
    [self e_showHudText:@""];
    WeakSelf
    [TokenApi authCompanyWithDid:_did companyName:_companyName creditCode:_code name:_name identityCode:_identityCode licenseImg:image isOrg:_isOrg handler:^(TKResultData *rdata) {
        if (rdata.success) {
            [weakSelf e_showMessage:@"成功"];
        }else{
            [weakSelf e_showMessage:rdata.message];
        }
    }];
}

- (void)initView{
    UIView *bview = [UIView token_bottom_button:self action:@selector(commitClick) title:@"认证"];
    [self.view addSubview:bview];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EWidth, EHeight-bview.height) style:(UITableViewStyleGrouped)];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = ERGBColor(0xF1F1F1);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:true];
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
        [_dataArray addObjectsFromArray:@[self.cellDict[@"companyC"],self.cellDict[@"codeC"],self.cellDict[@"nameC"]]];
        [_dataArray addObject:self.cellDict[@"imageHeaderC"]];
        [_dataArray addObject:self.cellDict[@"licenseC"]];
    }
    return _dataArray;
}


- (void)segmentChanged:(NSInteger)tag{
    self.selectTag = tag;
    [self.dataArray replaceObjectAtIndex:self.dataArray.count-1 withObject:tag == 0 ? self.cellDict[@"licenseC"] :self.cellDict[@"letterC"]];
    [self.tableView reloadData];
}

- (NSMutableDictionary<NSString *,id<EListViewProtocol>> *)cellDict{
    if (_cellDict == nil) {
        _cellDict = [NSMutableDictionary dictionary];

        TKTextFieldModel *md1 = [[TKTextFieldModel alloc] init];
        md1.title = @"工商注册名字";md1.value = _companyName;md1.disabled = true;
        
        TKTextFieldModel *md2 = [[TKTextFieldModel alloc] init];
        md2.title = @"统一社会信用代码";md2.value = _code;md2.disabled = false;md2.placeholder = @"信用代码";
        
        TKTextFieldModel *md3 = [[TKTextFieldModel alloc] init];
        md3.title = @"法定代表人";md3.value = _name;md3.disabled = false;
        
        TKTextFieComonCell *cell1 = [[TKTextFieComonCell alloc] init];
        TKTextFieComonCell *cell2 = [[TKTextFieComonCell alloc] init];
        TKTextFieComonCell *cell3 = [[TKTextFieComonCell alloc] init];
        [cell1 updateData:md1];
        [cell2 updateData:md2];
        [cell3 updateData:md3];
        
        _cellDict[@"companyC"] = (id)cell1;
        _cellDict[@"codeC"] = (id)cell2;
        _cellDict[@"nameC"] = (id)cell3;
        
        TokenCompanyCertificationTitleCell *cell4 = [TokenCompanyCertificationTitleCell new];
        WeakSelf
        cell4.e_handler = ^(NSNumber *data) {
            [weakSelf segmentChanged:data.integerValue];
        };
        [cell4 updateData:@[@"营业执照认证",@"公函认证"]];
        _cellDict[@"imageHeaderC"] = (id)cell4;
        TokenCompanyBusinessLicenseCell *cell5 = [TokenCompanyBusinessLicenseCell new];
        TokenCompanyLetterCell *cell6 = [TokenCompanyLetterCell new];
        [cell6 updateData:@[ESafeString(_did),ESafeString(_name),ESafeString(_identityCode),ESafeString(_companyName)]];
        _cellDict[@"licenseC"] = (id)cell5;
        _cellDict[@"letterC"] = (id)cell6;
    }
    return _cellDict;
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
