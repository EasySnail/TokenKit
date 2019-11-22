//
//  HomeViewController.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSArray *array = @[@{@"vc":@"MenuViewController",@"title":@"首页"},
                      // @{@"vc":@"MessageViewController",@"title":@"消息"},
                       //@{@"vc":@"ShoppingViewController",@"title":@"购物"},
                       @{@"vc":@"MineViewController",@"title":@"我的"}];
    
    NSMutableArray *views = [NSMutableArray array];
    for (NSDictionary *dc in array){
        UIViewController *vc = [NSClassFromString(dc[@"vc"]) new];
        vc.title = dc[@"title"];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [views addObject:nvc];
    }
    
    self.viewControllers = views;
    
    
    // Do any additional setup after loading the view.
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
