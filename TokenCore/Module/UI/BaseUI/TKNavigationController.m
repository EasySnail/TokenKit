//
//  TKNavigationController.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKNavigationController.h"
#import <EServiceSDK/EServiceSDK.h>

@interface TKNavigationController ()

@end

@implementation TKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *textAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationBar.barTintColor = ERGBColor(0x00C1CE);
    
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
