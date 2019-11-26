//
//  TokenUIApi.h
//  TokenSDK
//
//  Created by easy on 2019/10/17.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TKNavigationController.h"
#import <TokenSDK/TokenSDK.h>
#import <TokenSDK/TokenSDK-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenUIApi : NSObject

/**
 *  身份密码页
 *
 *  @return viewController
 */

+ (UINavigationController *)token_identityPasswordVC:(void (^)(NSString* did))successBlock;


/**
*  打开身份密码页
* @param phone 手机
* @param successBlock 公司认证成功后，回调hash
*
*/
+ (void)open_identityPasswordVCWithPhone:(NSString *__nullable)phone from:(UIViewController *)fromVC handler:(void (^)(NSString* did))successBlock;


/**
 *  链信认证
 * @param did did
 * @param successBlock 公司认证成功后，回调hash
 *
 */
+ (void)open_authenticationVCWithDid:(NSString *)did companyName:(NSString *)companyName code:(NSString * __nullable)code from:(UIViewController *)fromVC handler:(void (^)(NSString *hash))successBlock;



/**
 *  实名身份认证
 * @param did did
 * @param fromVC 跳转页面
 */

+ (void)open_identityAuthenticationVCWithDid:(NSString *)did from:(UIViewController *)fromVC handler:(void (^)(NSString *hash))successBlock;


/**
 * 认证详情，说明
 * @param did did
 * @param explain 是否包含说明
 */

+ (void)open_certificationDetailVCWithDid:(NSString *)did isExplain:(BOOL)explain from:(UIViewController *)fromVC;




/**
 *  企业认证
 *
 *  @return viewController
 */
+ (UIViewController *)token_companyAuthenticationVC:(NSString *)did code:(NSString * __nullable)code companyName:(NSString *)companyName handler:(void (^)(id))successBlock;

/**
 *  组织认证
 *
 *  @return viewController
 */
+ (UIViewController *)token_orgAuthenticationVC:(NSString *)did code:(NSString * __nullable)code companyName:(NSString *)companyName handler:(void (^)(id))successBlock;



/**
 *  打开密码弹框
 *
 *  @param did did
 */
+ (void)open_verifyPasswordWithDid:(NSString *)did handler:(void(^)(void))handler;

/**
 *  打开手机号验证弹框
 *
 *  @param did did
 */
+ (void)open_verifyPhoneViewWithDid:(NSString *)did handler:(void(^)(void))handler;



@end

NS_ASSUME_NONNULL_END
