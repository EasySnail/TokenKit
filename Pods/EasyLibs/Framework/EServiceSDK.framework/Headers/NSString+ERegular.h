//
//  NSString+ERegular.h
//  EServiceSDK
//
//  Created by 葛少玉 on 28/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ERegular)

- (BOOL)validateURL;
- (BOOL)validateNumber;
- (BOOL)validateChineseCharacters;
- (BOOL)validateEmail;
- (BOOL)validateMobile;
- (BOOL)validateRegex:(NSString *)regex;

- (BOOL)validateIdentity;               ///< 身份证

@end

NS_ASSUME_NONNULL_END
