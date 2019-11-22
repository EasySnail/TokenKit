//
//  TKCompanyAuthenticationVC.h
//  TokenSDK
//
//  Created by easy on 2019/10/28.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKCompanyAuthenticationVC : TKBaseViewController


@property(nonatomic,copy)NSString *code;                ///<社会信用代码
@property(nonatomic,copy)NSString *companyName;         ///<公司名称
@property(nonatomic,copy)NSString *name;                ///<法人
@property(nonatomic,copy)NSString *did;                ///<did
@property(nonatomic,assign)BOOL isOrg;                 ///是否是组织认证


@end

NS_ASSUME_NONNULL_END
