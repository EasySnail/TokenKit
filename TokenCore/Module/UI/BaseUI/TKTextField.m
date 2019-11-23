//
//  TKTextField.m
//  TokenCard
//
//  Created by easy on 2019/5/28.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKTextField.h"
#import <EServiceSDK/EServiceSDK.h>

@interface TKTextField()<UITextFieldDelegate>

@end

@implementation TKTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.textColor = ERGBColor(0x374F66);
        [self addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
        self.inputAccessoryView = [self token_inputView];
    }
    return self;
}

- (void)textChanged{
    NSString *ftext = self.text;
    if (self.maxLength > 0 && self.maxLength < self.text.length) {
        ftext = [self.text substringToIndex:_maxLength];
        self.text = ftext;
    }
    if (self.textFieldDidChangeBlock) {
        self.textFieldDidChangeBlock(self);
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    [super setSecureTextEntry:secureTextEntry];
    if (self.textContentType == nil) {
        if (@available(iOS 12.0, *)) {
            self.textContentType = UITextContentTypeNewPassword;
        } else if (@available(iOS 11.0, *)) {
            self.textContentType = UITextContentTypePassword;
        } else {
    
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.textFieldShouldReturnBlock) {
        return self.textFieldShouldReturnBlock(textField);
    }
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textFieldDidEndEditingBlock) {
        self.textFieldDidEndEditingBlock(textField);
    }
}

- (UIView *)token_inputView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 35)];
    view.backgroundColor = ERGBColor(0xf8f8f8);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 0.5)];
    line.backgroundColor = ERGBColor(0xcdcdcd);
    [view addSubview:line];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(EWidth-50, 0, 50, view.height)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:ERGBColor(0x00C1CE) forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
}
- (void)buttonClick{
    [self resignFirstResponder];
    if (self.textFieldDidFinishedBlock) {
        self.textFieldDidFinishedBlock(self);
    }
}

@end
