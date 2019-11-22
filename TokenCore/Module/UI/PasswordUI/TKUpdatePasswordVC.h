//
//  TKUpdatePasswordVC.h
//  TokenKit
//
//  Created by easy on 2019/11/18.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKUpdatePasswordVC : TKBaseViewController


- (instancetype)initWithDid:(NSString *)did password:(NSString * __nullable)pwd;    ///< pwd: nil=修改,不空=重置

@end

NS_ASSUME_NONNULL_END
