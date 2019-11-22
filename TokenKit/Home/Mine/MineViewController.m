//
//  MineViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "MineViewController.h"
#import <EServiceSDK/EServiceSDK.h>

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"链信认证",@"弹框测试1",@"退出"];
    for (int i = 0; i < titles.count; ++i) {
        UIButton *button = [UITools button:CGRectMake(0, 0, 150, 40) title:titles[i]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.center = CGPointMake(self.view.center.x, self.view.center.y-150 + i*70);
        button.tag = i;
        [self.view addSubview:button];
    }
}



- (void)buttonClick:(UIButton *)bt{
    
    NSString *did = Account.sharedInstance.did;
    //链信认证
    if (bt.tag == 0) {
        [TokenUIApi open_authenticationVCWithDid:did companyName:@"投肯科技" code:nil from:self handler:^(NSString * _Nonnull hash) {
        }];
    }
    //弹框测试1
    if (bt.tag == 1){
        [TokenUIApi open_verifyPasswordWithDid:did handler:^{
            
        }];
    }
    //退出
    if (bt.tag == 2){
        [self alertMessage:@"确定退出" actions:@[@"取消",@"确定"] handler:^(NSInteger index) {
            if (index == 1) {
                [Account clear];
                [UIApplication sharedApplication].delegate.window.rootViewController = [NSClassFromString(@"LoginViewController") new];
            }
        }];
    }
}

- (void)buttonClick1{
    
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
