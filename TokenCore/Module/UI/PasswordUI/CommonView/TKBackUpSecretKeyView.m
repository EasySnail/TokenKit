//
//  TKBackUpSecretKeyView.m
//  TokenCard
//
//  Created by easy on 2019/5/22.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBackUpSecretKeyView.h"
#import "TKBackUpInputPasswordView.h"
#import "TKHeader.h"
//#import "TokenSDK/TokenSDK-Swift.h"




@interface TKBackupSecretKeyModel : NSObject

@property(nonatomic,copy)NSString *pwdEncryptedSecretKey;
@property(nonatomic,copy)NSString *securityQuestionEncryptedSecretKey;
@property(nonatomic,strong)NSArray *securityQuestionIds;

@end

@implementation TKBackupSecretKeyModel

@end





@interface TKBackUpSecretKeyView()

@property(nonatomic,weak)UIView *backgroundView;
@property(nonatomic,retain)TKBackUpInputPasswordView *inputPasswordView;        //输入备份密码
@property(nonatomic,weak)UIView *currentView;
@property(nonatomic,assign)NSInteger type;                                     //0=手机，1=密码

@end

@implementation TKBackUpSecretKeyView


static TKBackUpSecretKeyView *_sharedInstance = nil;
static TKBackUpSecretKeyView *_pswsharedInstance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedInstance) {
            _sharedInstance = [[TKBackUpSecretKeyView alloc] initWithSupView:nil type:0];
        }
    });
    return _sharedInstance;
}

+ (instancetype)pswsharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_pswsharedInstance) {
            _pswsharedInstance = [[TKBackUpSecretKeyView alloc] initWithSupView:nil type:1];
        }
    });
    return _pswsharedInstance;
}

- (instancetype)initWithSupView:(UIView *)supView type:( NSInteger)type
{
    self = [super initWithFrame:CGRectMake(0, 0, EWidth, EHeight)];
    if (self) {
        self.type = type;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.backgroundView = supView == nil ? [UIApplication sharedApplication].keyWindow : supView;
        self.currentView = self.inputPasswordView;
    }
    return self;
}

+ (void)showWithDid:(NSString *)did handler:(void(^)(BOOL success))handler{
    __weak TKBackUpSecretKeyView *view = [self sharedInstance];
    view.inputPasswordView.e_handler = ^(NSArray *data) {
        ///解密
        NSString *phone = data.firstObject;
        NSString *code = data.lastObject;
        if (phone.validateMobile && code.length > 0) {
            [view e_showHudText:@""];
//            [TokenApi initSDKWithDid:did phone:phone code:code handler:^(BOOL sc, NSString * error) {
//                if (sc) {
//                    [view e_hideHud];
//                    [view hide:true];
//                    handler(true);
//                }else{
//                    [view e_showMessage:error];
//                }
//            }];
        }else{
            [view e_showMessage:@"输入有误"];
            handler(false);
        }
    };
    [view show];
}


+ (void)showPasswordViewWithDid:(NSString *)did handler:(void(^)(BOOL success))handler{
    __weak TKBackUpSecretKeyView *view = [self pswsharedInstance];
    view.inputPasswordView.e_handler = ^(id  _Nullable data) {
        NSString *pwd = data;
        if (pwd.length == 0) {
            return [view e_showMessage:@"请输入密码"];
        }
        [TokenApi availablePasswordWithDid:did password:pwd handler:^(TKResultData *data) {
            if (data.success) {
                [view hide:true];
                handler(true);
            }else{
                [view e_showMessage:data.message];
            }
        }];
    };
    [view show];
}

- (void)show{
    if (self.superview != nil) {return;}
    [self.inputPasswordView reset];
    [self.backgroundView addSubview:self];
    self.currentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    self.currentView.alpha = 1;
    self.currentView.hidden = false;
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.currentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {}];
}


- (void)hide:(BOOL)animation{
    if (!animation) {
        [self removeFromSuperview];
        self.currentView.hidden = true;
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundColor = [UIColor clearColor];
            self.currentView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.currentView.alpha = 1;
            self.currentView.hidden = true;
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:true];
    
//    [self hide:true];
    
}

/// 解密备份密码 view
- (TKBackUpInputPasswordView *)inputPasswordView{
    if (_inputPasswordView == nil) {
        WeakSelf
        _inputPasswordView = [self tk_crateInPutView];
        _inputPasswordView.cancelHandler  = ^(id  _Nullable data) {
            [weakSelf hide:true];
        };
        [self addSubview:_inputPasswordView];
    }
    return _inputPasswordView;
}

/// view动画过度
- (void)showView:(UIView *)sview hideView:(UIView *)hideView{
    self.currentView = sview;
    hideView.hidden = true;
}

///< 创建view
- (TKBackUpInputPasswordView *)tk_crateInPutView{
    TKBackUpInputPasswordView *view = [[TKBackUpInputPasswordView alloc] initWithFrame:CGRectMake(0, 0, ViewScale(300), _type != 0 ? 310 : 350) type:_type];
    view.center = CGPointMake(self.centerX, self.centerY-50);
    return view;
}



@end
