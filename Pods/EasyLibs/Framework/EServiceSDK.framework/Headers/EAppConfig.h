//
//  EAppConfig.h
//  EServiceSDK
//
//  Created by 葛少玉 on 12/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define EAppConfigManager [EAppConfig sharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface EAppConfig : NSObject

@property(nonatomic,copy,readonly)NSString *deviceId;           ///<设备ID
@property(nonatomic,copy,readonly)NSString *systemVersion;      ///<系统版本
@property(nonatomic,assign,readonly)BOOL isPhone;
@property(nonatomic,assign,readonly)BOOL isPad;
@property(nonatomic,assign,readonly)BOOL isFringeScreen;        ///<是否有刘海，x系列
@property(nonatomic,assign,readonly)CGFloat screenWidth;
@property(nonatomic,assign,readonly)CGFloat screenHeight;
@property(nonatomic,assign,readonly)CGFloat safeBottomHeight;
@property(nonatomic,assign,readonly)CGFloat statusBarHeight;
@property(nonatomic,assign,readonly)CGFloat navigationHeight;
@property(nonatomic,assign,readonly)CGFloat tabarHeight;

+ (instancetype)sharedInstance;

+ (NSString *)timestamp;        ///<时间戳
+ (NSString *)uuid;             ///<生成唯一ID

@end

NS_ASSUME_NONNULL_END



