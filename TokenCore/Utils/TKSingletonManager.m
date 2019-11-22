//
//  TKSingletonManager.m
//  TokenKit
//
//  Created by easy on 2019/11/20.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKSingletonManager.h"

@implementation TKSingletonManager


static NSDateFormatter *_sharedDateFormatter = nil;

+ (NSDateFormatter *)sharedDateFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedDateFormatter) {
            _sharedDateFormatter = [[NSDateFormatter alloc] init];
        }
    });
    return _sharedDateFormatter;
}


@end
