//
//  NSData+EEncode.h
//  EServiceSDK
//
//  Created by 葛少玉 on 20/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSData (EEncode)

- (NSData *)e_aes256EncryptWithKey:(NSData *)key iv:(NSData * __nullable)iv;
- (NSData *)e_aes256DecryptWithkey:(NSData *)key iv:(NSData * __nullable)iv;

- (NSString *)e_binary_string;

@end

NS_ASSUME_NONNULL_END
