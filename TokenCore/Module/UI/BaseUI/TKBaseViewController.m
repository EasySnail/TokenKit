//
//  TKBaseViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBaseViewController.h"
#import "TKHeader.h"

@interface TKBaseViewController ()

@end

@implementation TKBaseViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationBackEnabled = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_navigationBackEnabled || self.navigationController.viewControllers.firstObject != self) {
        [self e_setBackButton:[[UIImage token_image:@"token_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    }
    
    // Do any additional setup after loading the view.
}

- (void)e_didiBackClick:(id)sender{
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
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
