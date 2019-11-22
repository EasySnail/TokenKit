//
//  LoginViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *login = [UITools button:CGRectMake(0, 0, 250, 40) title:@"登 陆 成 功"];
    [login addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    login.center = self.view.center;
    [self.view addSubview:login];
    // Do any additional setup after loading the view.
}

- (void)loginClick{
    //设置身份密码
    UINavigationController *vc = [TokenUIApi token_identityPasswordVC:^(NSString * _Nonnull did) {
        //设置成功,存储到服器
        [Account updateData:@{@"did":did}];
        [self dismissViewControllerAnimated:true completion:nil];
        [self presentViewController:[NSClassFromString(@"HomeViewController") new] animated:true completion:nil];
    }];
    [self presentViewController:vc animated:true completion:nil];
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
