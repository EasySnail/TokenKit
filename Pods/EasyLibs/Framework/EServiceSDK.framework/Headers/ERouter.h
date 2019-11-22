//
//  ERouter.h
//  EServiceSDK
//
//  Created by easy on 2019/5/17.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ERouterParam;
typedef void(^RouterHandler)(id param);

@interface ERouter : NSObject
/**
 单例模式
 */
+ (instancetype)sharedInstance;

/**
 注册路由方法
 @param url      注册的URL参数
 @param block    存储参数的block,里面可以实现具体的跳转到哪里，以及跳转方式等
 */
+ (void)registerUrl:(NSString *)url handler:(RouterHandler)block;

/**
 打开路由界面
 @param param   注册的URL参数
 @param url     注册的对应界面
 */
+ (void)openURL:(NSString *)url param:(ERouterParam * __nullable)param;
+ (void)openURL:(NSString *)url dict:(NSDictionary * __nullable)dict;
+ (void)openURL:(NSString *)url;

@end




typedef NS_ENUM(NSUInteger, ERouterType) {
    ERouterTypePush,        
    ERouterTypePresent,
    ERouterTypeRoot,
};

@interface ERouterParam : NSObject

@property(nonatomic,assign)ERouterType routerType;      ///< 跳转类型
@property(nonatomic,retain)id data;                     ///< 参数
@property(nonatomic,weak)UIViewController *vc;          ///< 当前界面跳转
@property(nonatomic,copy)void(^handler)(id data);       ///< 参数

+ (ERouterParam *)paramWithData:(id __nullable)data fromVC:(UIViewController *)vc;
+ (ERouterParam *)routerParam:(ERouterType)type fromVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
