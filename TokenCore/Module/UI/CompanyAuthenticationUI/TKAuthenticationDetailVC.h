//
//  TKAuthenticationDetailVC.h
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKAuthenticationDetailVC : TKBaseViewController

@property(nonatomic,assign)BOOL isExplain; ///< false=详情，true=说明
@property(nonatomic,copy)NSString *did;

@end

NS_ASSUME_NONNULL_END
