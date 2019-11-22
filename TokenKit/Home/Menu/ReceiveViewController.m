//
//  ReceiveViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/19.
//  Copyright © 2019 easy. All rights reserved.
//

#import "ReceiveViewController.h"
#import <ELibsManager/ELibsManager.h>
#import <EServiceSDK/EServiceSDK.h>

@interface ReceiveViewController ()
@property(nonatomic,retain)NSMutableArray *goodsArray;
@end

@implementation ReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:NSClassFromString(@"ReceiveListCell") forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)comit:(BOOL)state cid:(NSString *)cid{
    if (state) {
        //转个他人，名称，did
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"他人名称";
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"他人did";
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];;
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            NSString *toName = alert.textFields.firstObject.text;
            NSString *toDid = alert.textFields.lastObject.text;
            if (toName.length > 0 && toDid.length > 0) {
                [self comitRequest:cid toDid:toDid toName:toName];
            }
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }else{
        [self comitRequest:cid toDid:nil toName:nil];
    }
}

- (void)comitRequest:(NSString *)cid toDid:(NSString *)toDid toName:(NSString *)toName{
    [self e_showHudText:@""];
    [TokenApi receiptGoodsWithDid:Account.sharedInstance.did certId:cid toDid:toDid toName:toName handler:^(TKResultData * data) {
        if (data.success) {
            [self e_hideHud];
            int j = -1;
            for (int i = 0; i < self.goodsArray.count; ++i) {
                if ([self.goodsArray[i][@"id"] isEqualToString:cid]) {
                    j = i;
                    break;
                }
            }
            if (j >= 0) {
                [self.goodsArray removeObjectAtIndex:j];
                [self.tableView reloadData];
            }

        }else{
            [self e_showMessage:data.message];
        }
    }];
}

- (void)loadNewData{
    self.goodsArray = [NSMutableArray array];
    [TokenApi getGoodsHistoryWithDid:Account.sharedInstance.did handler:^(TKResultData *data) {
        [self.tableView.mj_header endRefreshing];
        if ([data.data isKindOfClass:[NSArray class]]) {
            for (TokenSignatureHistoryModel *md in data.data) {
                TokenSignatureModel *smd = [md confirmSignatureModelWithDid:Account.sharedInstance.did];
                if (smd != nil) {
                    //发个自己，自己确认
                    TokenGoodsItem *gmd = (TokenGoodsItem *)(md.signature.lastObject);
                    [self.goodsArray addObject:@{
                                                 @"text":[NSString stringWithFormat:@"%@ %@",md.content, gmd.commodityName],
                                                 @"id":md.id}];
                }
            }
            if (self.goodsArray.count == 0) {
                [self e_showMessage:@"暂无数据"];
            }
        }
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WeakSelf
    [cell updateData:self.goodsArray[indexPath.row]];
    if (cell.e_handler == nil) {
        cell.e_handler = ^(NSArray *array) {
            [weakSelf comit:((NSNumber *)array.firstObject).boolValue cid:array.lastObject];
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;;
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






@interface ReceiveListCell()
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UIButton *bt1;
@property(nonatomic,retain)UIButton *bt2;
@property(nonatomic,retain)NSString *cid;

@end
@implementation ReceiveListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        self.label = label;
        
        
        self.bt1 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        self.bt2 = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        [self.contentView addSubview:_bt1];
        [self.contentView addSubview:_bt2];
        
        [_bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bt1 setTitle:@"转给他人" forState:UIControlStateNormal];
        [_bt2 setTitle:@"确认收货" forState:UIControlStateNormal];
        _bt1.backgroundColor = [UIColor colorWithRed:0x00/255.0 green:0xC1/255.0 blue:0xce/255.0 alpha:1];
        _bt2.backgroundColor = _bt1.backgroundColor;
        _bt1.layer.cornerRadius = 3;
        _bt2.layer.cornerRadius = 3;
        _bt1.layer.masksToBounds = true;
        _bt2.layer.masksToBounds = true;
        _bt1.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        _bt2.titleLabel.font = _bt1.titleLabel.font;
        [_bt2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bt1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        
        [_bt1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.centerX.equalTo(self.mas_centerX).offset(-80);
        }];
        [_bt2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
            make.centerX.equalTo(self.mas_centerX).offset(80);
        }];
    }
    return self;
}

- (void)buttonClick:(UIButton *)bt{
    if (self.e_handler) {
        self.e_handler(@[@(bt == self.bt1),ESafeString(self.cid)]);
    }
}

- (void)updateData:(id)data{
    self.label.text = data[@"text"];
    self.cid = data[@"id"];
}

@end
