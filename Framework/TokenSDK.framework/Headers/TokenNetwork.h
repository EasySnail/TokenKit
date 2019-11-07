//
//  TokenNetwork.h
//  TokenSDK
//
//  Created by easy on 2019/10/11.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EResponseData;


NS_ASSUME_NONNULL_BEGIN



FOUNDATION_EXPORT NSString * const tk_api_store_data;
FOUNDATION_EXPORT NSString * const tk_api_get_store;
FOUNDATION_EXPORT NSString * const tk_api_did;
FOUNDATION_EXPORT NSString * const tk_api_user_auth;
FOUNDATION_EXPORT NSString * const tk_api_phone_code;
FOUNDATION_EXPORT NSString * const tk_api_node_service;
FOUNDATION_EXPORT NSString * const tk_api_store_phone;
FOUNDATION_EXPORT NSString * const tk_api_letter_image;
FOUNDATION_EXPORT NSString * const tk_api_upload;
FOUNDATION_EXPORT NSString * const tk_api_did_fork;
FOUNDATION_EXPORT NSString * const tk_api_company_auth;


@interface TokenNetwork : NSObject

//+ (void)requestWithApi:(NSString *)api mClass:(NSString *__nullable)cls param:(id __nullable)param handler:(ResponseHandler)handler;
//
//+ (void)uploadFile:(NSData *)file param:(NSDictionary *)param handler:(ResponseHandler)handler;

+ (void)requestWithApi:(NSString *)api mClass:(NSString *__nullable)cls param:(id __nullable)param handler:(void (^)(EResponseData* _Nonnull))handler;




+ (void)uploadFile:(NSData *)file param:(NSDictionary *)param handler:(void (^)(EResponseData* _Nonnull))handler;

@end

NS_ASSUME_NONNULL_END
