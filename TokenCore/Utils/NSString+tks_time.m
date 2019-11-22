//
//  NSString+tks_time.m
//  TokenKit
//
//  Created by easy on 2019/11/20.
//  Copyright © 2019 easy. All rights reserved.
//

#import "NSString+tks_time.h"
#import "TKSingletonManager.h"

@implementation NSString (tks_time)

- (NSString *)tks_timeStampToDateWithFormat:(NSString *)formatter{
    NSDateFormatter *dateFormatter = TKSingletonManager.sharedDateFormatter;
    double dTimeStamp = [self doubleValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dTimeStamp];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)tks_timeStampToDate{
    return [self tks_timeStampToDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}


@end
