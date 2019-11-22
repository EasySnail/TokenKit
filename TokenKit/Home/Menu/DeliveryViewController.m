//
//  DeliveryViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/19.
//  Copyright © 2019 easy. All rights reserved.
//

#import "DeliveryViewController.h"
#import <ELibsManager/ELibsManager.h>


@interface DeliveryViewController ()

@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发货";
    [self initData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.title style:(UIBarButtonItemStylePlain) target:self action:@selector(comit)];
    // Do any additional setup after loading the view.
}

- (void)comit{
    [self.view endEditing:true];
    for (JTextFieldCell *cell in self.dataArray) {
        if (cell.textField.text.length <= 0) {
            return [self e_showMessage:@"输入完成信息"];
        }
    }
    NSString *did = Account.sharedInstance.did;
    NSString *sellerName = self.dataArray[0].textField.text;
    NSString *buyerName = self.dataArray[1].textField.text;
    NSString *buyerDID = self.dataArray[2].textField.text;
    NSString *commodityName = self.dataArray[3].textField.text;
    NSInteger commodityCount = self.dataArray[4].textField.text.integerValue;
    
    
    TokenGoodsModel *md = [TokenGoodsModel deliveryWithDid:did sellerName:sellerName buyerName:buyerName buyerDID:buyerDID commodityName:commodityName commodityCount:commodityCount];
    [self e_showHudText:@""];
    [TokenApi deliveryGoodsWithData:md handler:^(TKResultData *data) {
        if (data.success) {
            [self e_showMessage:@"发货成功"];
        }else{
            [self e_showMessage:data.message];
        }
    }];
}

- (void)initData{
    JTextFieldCell *cell1 = [[JTextFieldCell alloc] init];
    JTextFieldCell *cell2 = [[JTextFieldCell alloc] init];
    JTextFieldCell *cell3 = [[JTextFieldCell alloc] init];
    JTextFieldCell *cell4 = [[JTextFieldCell alloc] init];
    JTextFieldCell *cell5 = [[JTextFieldCell alloc] init];
    [cell1 updateTitle:@"店家名称"];
    [cell2 updateTitle:@"买家"];
    [cell3 updateTitle:@"买家did"];
    [cell4 updateTitle:@"商品名称"];
    [cell5 updateTitle:@"数量"];

    self.dataArray = @[cell1,cell2,cell3,cell4,cell5];
    
    
    cell3.textField.text = Account.sharedInstance.did;
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
