//
//  Account.h
//  TokenTest
//
//  Created by easy on 2019/11/6.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject


@property(nonatomic,copy)NSString *did;


+ (instancetype)sharedInstance;

+ (void)updateData:(NSDictionary *)param;

+ (BOOL)isLogin;

+ (void)clear;

@end

NS_ASSUME_NONNULL_END
