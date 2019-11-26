//
//  NSString+TKEncode.h
//  TokenSDK
//
//  Created by easy on 2019/10/14.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TKEncode)

+ (NSString *)tk_uuid;
- (NSString *)tk_encrypt:(NSString *)key;
- (NSString * _Nullable)tk_decrypt:(NSString *)key;

- (NSString *)tk_aes_encrypt:(NSString *)key;  ///< 加密
- (NSString *)tk_aes_decrypt:(NSString *)key;  ///< 解密

- (NSString *)tk_md5_key;

@end



@interface XXTEA : NSObject

+ (NSData *)encrypt:(NSData *)data key:(NSData *)key;
+ (NSData *)encrypt:(NSData *)data stringKey:(NSString *)key;

+ (NSString *)encryptToBase64String:(NSData *)data key:(NSData *)key;
+ (NSString *)encryptToBase64String:(NSData *)data stringKey:(NSString *)key;

+ (NSData *)encryptString:(NSString *)data key:(NSData *)key;
+ (NSData *)encryptString:(NSString *)data stringKey:(NSString *)key;

+ (NSString *)encryptStringToBase64String:(NSString *)data key:(NSData *)key;
+ (NSString *)encryptStringToBase64String:(NSString *)data stringKey:(NSString *)key;

+ (NSData *)decrypt:(NSData *)data key:(NSData *)key;
+ (NSData *)decrypt:(NSData *)data stringKey:(NSString *)key;

+ (NSData *)decryptBase64String:(NSString *)data key:(NSData *)key;
+ (NSData *)decryptBase64String:(NSString *)data stringKey:(NSString *)key;

+ (NSString *)decryptToString:(NSData *)data key:(NSData *)key;
+ (NSString *)decryptToString:(NSData *)data stringKey:(NSString *)key;

+ (NSString *)decryptBase64StringToString:(NSString *)data key:(NSData *)key;
+ (NSString *)decryptBase64StringToString:(NSString *)data stringKey:(NSString *)key;

@end

@interface NSData (XXTEA)

- (NSData *)xxteaEncrypt:(NSData *)key;
- (NSData *)xxteaDecrypt:(NSData *)key;

@end



NS_ASSUME_NONNULL_END
