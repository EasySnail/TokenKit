//
//  TokenUIApi.m
//  TokenSDK
//
//  Created by easy on 2019/10/17.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TokenUIApi.h"

#import "TKIIdentityPasswordVC.h"
#import "TKIdentityAuthenticationVC.h"
#import "TKCompanyAuthenticationVC.h"
#import "TKBackUpSecretKeyView.h"
#import "TKLXAuthenticationVC.h"
#import "TKAuthenticationDetailVC.h"
#import <EServiceSDK/EServiceSDK.h>


@implementation TokenUIApi


//设置密码
+ (UINavigationController *)token_identityPasswordVC:(void (^)(NSString* did))successBlock{
    TKIIdentityPasswordVC *vc = [[TKIIdentityPasswordVC alloc] init];
    vc.successBlock = successBlock;
    return [[TKNavigationController alloc] initWithRootViewController:vc];
}

+ (void)open_identityPasswordVCWithPhone:(NSString *__nullable)phone from:(UIViewController *)fromVC handler:(void (^)(NSString* did))successBlock{
    TKIIdentityPasswordVC *vc = [[TKIIdentityPasswordVC alloc] init];
    vc.successBlock = successBlock;
    vc.phone = phone;
    vc.successBlock = successBlock;
    [fromVC presentViewController:[[TKNavigationController alloc] initWithRootViewController:vc] animated:true completion:nil];
}


//重置密码
+ (UIViewController *)token_reset_identityPasswordVC:(NSString *)did handler:(void (^)(id data))successBlock{
//    TKIIdentityPasswordVC *vc = [[TKIIdentityPasswordVC alloc] initWithType:2];
//    vc.did = did;
//    vc.successBlock = successBlock;
    return nil;
}


//打开身份认证
+ (void)open_identityAuthenticationVCWithDid:(NSString *)did from:(UIViewController *)fromVC handler:(void (^)(NSString *hash))successBlock{
    TKIdentityAuthenticationVC *vc = [[TKIdentityAuthenticationVC alloc] init];
    __weak TKIdentityAuthenticationVC *weakVc = vc;
    vc.successBlock = ^(id  _Nonnull data) {
        [weakVc alertMessage:@"认证成功" actions:@[@"确定"] handler:^(NSInteger index) {
            [fromVC dismissViewControllerAnimated:true completion:nil];
            successBlock(data);
        }];
    };
    vc.did = did;
    vc.navigationBackEnabled = true;
    UINavigationController *nvc = [[TKNavigationController alloc] initWithRootViewController:vc];;
    [fromVC presentViewController:nvc animated:true completion:nil];
}

//打开链信认证界面
+ (void)open_authenticationVCWithDid:(NSString *)did companyName:(NSString *)companyName code:(NSString * __nullable)code from:(UIViewController *)fromVC handler:(void (^)(NSString *hash))successBlock{
    TKLXAuthenticationVC *vc = [[TKLXAuthenticationVC alloc] init];
    vc.did = did;
    vc.navigationBackEnabled = true;
    vc.companyName = companyName;
    vc.code = code;
    vc.successBlock = successBlock;
    UINavigationController *nvc = [[TKNavigationController alloc] initWithRootViewController:vc];
    [fromVC presentViewController:nvc animated:true completion:nil];
}

//认证详情
+ (void)open_certificationDetailVCWithDid:(NSString *)did isExplain:(BOOL)explain from:(UIViewController *)fromVC{
    TKAuthenticationDetailVC *vc = [[TKAuthenticationDetailVC alloc] init];
    vc.isExplain = explain;
    vc.did = did;
    [fromVC presentViewController:[[TKNavigationController alloc] initWithRootViewController:vc] animated:true completion:nil];
}


//公司认证
+ (UIViewController *)token_companyAuthenticationVC:(NSString *)did code:(NSString * __nullable)code companyName:(NSString *)companyName handler:(void (^)(id))successBlock{
    TKCompanyAuthenticationVC *vc = [[TKCompanyAuthenticationVC alloc] init];
    vc.successBlock = successBlock;
    vc.code = code;
    vc.companyName = companyName;
    vc.did = did;
    vc.isOrg = false;
    return vc;
}


//组织认证
+ (UIViewController *)token_orgAuthenticationVC:(NSString *)did code:(NSString * __nullable)code companyName:(NSString *)companyName handler:(void (^)(id))successBlock{
    TKCompanyAuthenticationVC *vc = [[TKCompanyAuthenticationVC alloc] init];
    vc.successBlock = successBlock;
    vc.code = code;
    vc.companyName = companyName;
    vc.did = did;
    vc.isOrg = true;
    return vc;
}


+ (void)open_verifyPhoneViewWithDid:(NSString *)did handler:(void(^)(void))handler{
    [TKBackUpSecretKeyView showWithDid:did handler:^(BOOL success) {
        if (success && handler) {
            handler();
        }
    }];
}


+ (void)open_verifyPasswordWithDid:(NSString *)did handler:(void(^)(void))handler{
    [TKBackUpSecretKeyView showPasswordViewWithDid:did handler:^(BOOL success) {
        if (success && handler) {
            handler();
        }
    }];
}


@end
