//
//  TKBaseViewController.h
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKBaseViewController : UIViewController

@property(nonatomic,assign)BOOL navigationBackEnabled;        ///< 显示返回,默认true

@property(nonatomic,copy)void(^successBlock)(id data);

@end

NS_ASSUME_NONNULL_END
