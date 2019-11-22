//
//  TKLXAuthenticationVC.h
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKLXAuthenticationVC : TKBaseViewController

@property(nonatomic,copy)NSString *did;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *companyName;


@end

NS_ASSUME_NONNULL_END
