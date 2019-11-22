//
//  TKBackUpInputPasswordView.m
//  TokenCard
//
//  Created by easy on 2019/5/22.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBackUpInputPasswordView.h"
#import "TKHeader.h"
#import "TKTextField.h"

@interface TKBackUpInputPasswordView()<UITextFieldDelegate,CAAnimationDelegate>{
    CGPoint sealPoint;
}
@property(nonatomic,retain)TKTextField *tf1;
@property(nonatomic,retain)TKTextField *tf2;
@property(nonatomic,retain)TKTextField *tf3;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,retain)TokenPhoneCode *codeView;
@property(nonatomic,retain)UIImageView *icon;

@property(nonatomic,retain)UIImageView *sealImageView;
@end

@implementation TKBackUpInputPasswordView

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = true;
        [self initView];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.sealImageView.hidden = false;
    
    [self setSealImageViewState:0];
    
    CABasicAnimation *anim1 = [CABasicAnimation animation];
    anim1.keyPath = @"position";
    anim1.fromValue = [NSValue valueWithCGPoint:CGPointMake(sealPoint.x+50, sealPoint.y+50)];
    anim1.toValue = [NSValue valueWithCGPoint:sealPoint];
    anim1.duration = 0.5;
    
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"transform.scale";
    anim2.fromValue = @(1);
    anim2.toValue = @(0.75);
    anim2.duration = 0.2;
    anim2.beginTime = 0.5;
    anim2.autoreverses = true;
    anim2.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *gourp = [CAAnimationGroup animation];
    gourp.duration = anim1.duration + anim2.duration*2.0;
    gourp.fillMode = kCAFillModeForwards;
    gourp.removedOnCompletion = false;
    gourp.delegate = self;
    gourp.animations = @[anim1,anim2];
    [self.sealImageView.layer addAnimation:gourp forKey:@"basic"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag == true) {
        [self setSealImageViewState:1];
    }
}
- (void)setSealImageViewState:(int)state{
    if (state == 0) {
        [_sealImageView.layer removeAllAnimations];
        _sealImageView.backgroundColor = [UIColor redColor];
    }else{
        _sealImageView.backgroundColor = [UIColor orangeColor];
    }
}

- (UIImageView *)sealImageView{
    if (_sealImageView == nil) {
        if (_type == 1) {
            _sealImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
            _sealImageView.layer.cornerRadius = _sealImageView.width * 0.5;
            [self addSubview:_sealImageView];
            _sealImageView.center = [_icon convertPoint:CGPointMake(_icon.width-20, _icon.height-20) toView:self];
            sealPoint = _sealImageView.center;
            _sealImageView.hidden = true;
            [self setSealImageViewState:0];
        }
    }
    return _sealImageView;
}

- (void)setPswError:(NSString *)error{
    self.titleLabel.text = @"密码错误";
    self.titleLabel.textColor = [UIColor redColor];
}
- (void)reset{
    self.titleLabel.text = _type == 0 ? @"身份确认" : @"身份密码";
    self.titleLabel.textColor = ERGBColor(0x333333);
    [self.codeView reset];
    self.tf1.text = @"";
    self.tf2.text = @"";
    self.tf3.text = @"";
    _sealImageView.hidden = true;
}
- (void)cancelClick{
    [self endEditing:true];
    if (self.cancelHandler) {self.cancelHandler(nil);}
}

- (void)commitClick{
    [self endEditing:true];
    if (self.e_handler) {
        if (_type == 0) {
            self.e_handler(@[ESafeString(_tf1.text),ESafeString(_tf2.text)]);
        }else{
            self.e_handler(ESafeString(_tf3.text));
        }
    }
}
- (void)initView{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = TKSDKFont(17);
    label.textColor = ERGBColor(0x333333);
    self.titleLabel = label;
    [self reset];
    
    if (_type == 0) {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 86, 100)];
        icon.image = [UIImage token_image:@"toke_identity_icon"];
        icon.centerX = self.width*0.5;
        [self insertSubview:icon atIndex:1];
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, self.width, self.height-42)];
        contentView.image = [UIImage token_image:@"toke_identity_bg"];
        contentView.userInteractionEnabled = true;
        [self insertSubview:contentView atIndex:0];

        label.y = 65;
        [contentView addSubview:label];
        
        TKTextField *tf = [self createTextField:label.y+label.height+20 placeholder:@"请输入您的手机号码" maxLength:11];
        self.tf1 = tf;
        [contentView addSubview:tf];
        
        
        TKTextField *tf1 = [self createTextField:tf.y+tf.height+10 placeholder:@"请输入您的验证码" maxLength:8];
        self.tf2 = tf1;
        tf1.rightViewMode = UITextFieldViewModeAlways;
        TokenPhoneCode *codeView = [[TokenPhoneCode alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
        self.codeView = codeView;
        WeakSelf
        codeView.e_handler = ^(TokenPhoneCode *cview) {
            if ([tf.text validateMobile]){
                [cview requestWithPhone:tf.text];
            }else{
                [weakSelf e_showMessage:@"请输入正确的手机号"];
            }
        };
        tf1.rightView = codeView;
        tf1.inputAccessoryView = [self token_inputView];
        [contentView addSubview:tf1];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewScale(15), tf1.height+tf1.y+10, contentView.width-ViewScale(30), 40)];
        detailLabel.numberOfLines = 2;
        detailLabel.text = @"提示：该操作涉及到您的隐私数据，需要输入您的身份证号码进行确认";
        detailLabel.textColor = ERGBColor(0xA7AAB3);
        detailLabel.font = TKSDKFont(13);
        [contentView addSubview:detailLabel];
    }else{
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 106, 122)];
        icon.image = [UIImage token_image:@"token_password_icon"];
        icon.centerX = self.width*0.5;
        [self insertSubview:icon atIndex:1];
        self.icon = icon;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, self.width, self.height-25)];
        contentView.layer.cornerRadius = 4;
        contentView.layer.masksToBounds = true;
        contentView.backgroundColor = [UIColor whiteColor];
        [self insertSubview:contentView atIndex:0];
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 125)];
        bgView.image = [UIImage token_image:@"token_password_bg"];
        [contentView addSubview:bgView];
        
        label.y = bgView.y+bgView.height+16;
        [contentView addSubview:label];
        
        self.tf3 = [self createTextField:label.y+label.height+15 placeholder:@"请输入您的身份密码" maxLength:16];
        _tf3.frame = CGRectMake(ViewScale(20), _tf3.y, contentView.width-ViewScale(40), 40);
        _tf3.keyboardType = UIKeyboardTypeDefault;
        _tf3.secureTextEntry = true;
        [contentView addSubview:_tf3];
    }
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-48, self.width*0.5, 48)];
    UIButton *commit = [[UIButton alloc] initWithFrame:CGRectMake(self.width*0.5, self.height-48, self.width*0.5, 48)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [commit setTitle:@"确定" forState:UIControlStateNormal];
    cancel.titleLabel.font = TKSDKFont(16);
    commit.titleLabel.font = TKSDKFont(16);
    [commit setTitleColor:ERGBColor(0x00C1CE) forState:UIControlStateNormal];
    [cancel setTitleColor:ERGBColor(0x999999) forState:UIControlStateNormal];
    cancel.layer.borderWidth = 0.5;
    commit.layer.borderWidth = 0.5;
    cancel.layer.borderColor = ERGBColor(0xF2F2F2).CGColor;
    commit.layer.borderColor = ERGBColor(0xF2F2F2).CGColor;
    [commit addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    [self addSubview:commit];
    
}


- (UIView *)token_inputView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 35)];
    view.backgroundColor = ERGBColor(0xf8f8f8);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 0.5)];
    line.backgroundColor = ERGBColor(0xcdcdcd);
    [view addSubview:line];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(EWidth-50, 0, 50, view.height)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = TKSDKFont(14);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:ERGBColor(0x00C1CE) forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
}

- (void)buttonClick{
    [self endEditing:true];
}

- (TKTextField *)createTextField:(CGFloat)dy placeholder:(NSString *)placeholder maxLength:(NSInteger)maxLength{
    TKTextField *tf = [[TKTextField alloc] initWithFrame:CGRectMake(ViewScale(15), dy, self.width-2*(ViewScale(15)), 35)];
    tf.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = placeholder;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.maxLength = maxLength;
    tf.inputAccessoryView = [self token_inputView];
    return tf;
}



@end



                                


@interface TokenPhoneCode()
@property(nonatomic,retain)NSTimer *timer;
@end
@implementation TokenPhoneCode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.font = TKSDKFont(15);
        [self setType:0];
        [self addSubview:_label];
        
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)requestWithPhone:(NSString *)phone{
    [self setType:2];
    WeakSelf
    [TokenApi sendCodeWithPhone:phone handler:^(BOOL sc, NSString *error) {
        if (sc) {
            [weakSelf startTime];
        }else{
            [weakSelf setType:0];
        }
    }];
}

- (void)startTime{
    [self.timer invalidate];
    __block NSInteger count = 10;
    WeakSelf
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        count--;
        if (count == -1) {
            [weakSelf setType:0];
            [weakSelf.timer invalidate];
        }else{
            weakSelf.label.text = [NSString stringWithFormat:@"       %@",@(count)];
        }
    }];
}

- (void)reset{
    [self.timer invalidate];
    [self setType:0];
}

- (void)setType:(NSInteger)type{
    if (type == 0) {
        _label.text = @"验证码";
        _label.textColor = ERGBColor(0x00C1CE);
        self.enabled = true;
    }else if (type == 2){
        self.enabled = false;
        _label.textColor = [UIColor lightGrayColor];
        _label.text = @"发送中";
    }else{
        self.enabled = true;
        _label.textColor = [UIColor lightGrayColor];
    }
}


- (void)buttonClick{
    if (self.e_handler) {
        self.e_handler(self);
    }
}

@end
