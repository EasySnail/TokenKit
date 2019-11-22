//
//  NSString+EEncode.h
//  EServiceSDK
//
//  Created by 葛少玉 on 28/12/18.
//  Copyright © 2018年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EEncode)

- (NSString *)e_urlEncoding;

- (NSString *)e_md5String;

- (NSString *)e_aes_encryptWithKey:(NSString *)key;

- (NSString *)e_aes_decryptWithKey:(NSString *)key;

- (NSData *)e_binary_data;

- (NSData *)e_binary_data1;

- (NSString *)e_toPinyin;

@end

NS_ASSUME_NONNULL_END
