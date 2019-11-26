//
//  TKIIdentityPasswordVC.h
//  TokenCard
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKIIdentityPasswordVC : TKBaseViewController

@property(nonatomic,copy)NSString *phone;

+ (NSString *)validatePassword:(NSString *)psw psw2:(NSString *)psw2;

@end

NS_ASSUME_NONNULL_END
