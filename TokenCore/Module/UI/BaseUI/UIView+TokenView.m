//
//  UIView+TokenView.m
//  TokenSDK
//
//  Created by easy on 2019/10/24.
//  Copyright © 2019 easy. All rights reserved.
//

#import "UIView+TokenView.h"
#import "TKHeader.h"

@implementation UIView (TokenView)

+ (UIView *)token_bottom_button:(id)target action:(SEL)action title:(NSString *)title{
    CGFloat dh = 45;
    CGFloat dt = 2;
    CGFloat db = 10;
    UIView *bview = [[UIView alloc] initWithFrame:CGRectMake(0, EHeight-(dh+dt+db)-ESafeBottomHeight, EWidth, (dh+dt+db)+ESafeBottomHeight)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(ViewScale(16), dt, EWidth-2*ViewScale(16), dh);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = ERGBColor(0x00C1CE);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [bview addSubview:button];
    return bview;
}

@end
