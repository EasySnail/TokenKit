//
//  EURLProtocol.h
//  EServiceSDK
//
//  Created by 葛少玉 on 26/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EURLProtocol : NSURLProtocol<NSURLSessionDelegate,NSURLSessionDataDelegate>

/**
 * yes=要解析的URL，false=系统处理
 **/
@property(nonatomic,copy)BOOL(^__nullable canInitWithRequestBlock)(NSURLRequest *request);

/**
 * 自定义处理一些URL
 **/
@property(nonatomic,copy)BOOL(^__nullable shouldCustomProcessingBlock)(NSURLRequest *request, EURLProtocol *protocol);

+ (instancetype)sharedInstance;
+ (void)e_register;
+ (void)e_unRegister;

@end

NS_ASSUME_NONNULL_END
