//
//  EAuthentication.h
//  EServiceSDK
//
//  Created by 葛少玉 on 15/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 info.plist添加
 Privacy - Face ID Usage Description
**/

@interface EAuthentication : NSObject

+ (void)excuteBiometrics:(void (^)(BOOL success))handler;

@end

NS_ASSUME_NONNULL_END
