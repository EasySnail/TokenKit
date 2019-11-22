//
//  TKSingletonManager.h
//  TokenKit
//
//  Created by easy on 2019/11/20.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKSingletonManager : NSObject

+ (NSDateFormatter *)sharedDateFormatter;

@end

NS_ASSUME_NONNULL_END
