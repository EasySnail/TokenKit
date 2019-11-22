//
//  UITools.m
//  TokenTest
//
//  Created by easy on 2019/11/6.
//  Copyright © 2019 easy. All rights reserved.
//

#import "UITools.h"

@implementation UITools

+ (UIButton *)button:(CGRect)frame title:(NSString *)title{
    UIButton *bt = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:15];
    bt.backgroundColor = [UIColor colorWithRed:0 green:193.0/255.0 blue:206.0/255.0 alpha:1];
    return bt;
}

@end
