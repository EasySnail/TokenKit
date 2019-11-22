//
//  EKeychainManager.h
//  EServiceSDK
//
//  Created by 葛少玉 on 13/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const EDeviceIdKey = @"general.deviceId.string";

@interface EKeychainManager : NSObject

+ (BOOL)insertData:(id)data key:(NSString *)key;
+ (id)query:(NSString *)key;
+ (BOOL)delete:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
