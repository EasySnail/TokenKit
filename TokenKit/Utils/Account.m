//
//  Account.m
//  TokenTest
//
//  Created by easy on 2019/11/6.
//  Copyright © 2019 easy. All rights reserved.
//

#import "Account.h"

@implementation Account


static Account *_sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
            NSString *key = [self savekey];
            NSString *did = [[NSUserDefaults standardUserDefaults] valueForKey:key];
            if (did.length > 0) {
                _sharedInstance.did = did;
            }
        }
    });
    return _sharedInstance;
}

+ (BOOL)isLogin{
    return Account.sharedInstance.did.length > 0;
}

+ (void)updateData:(NSDictionary *)param{
    if (param[@"did"]) {
        Account.sharedInstance.did = param[@"did"];
        [Account.sharedInstance save];
    }
}
+ (void)clear{
    NSString *key = [Account savekey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)save{
    NSString *key = [Account savekey];
    [[NSUserDefaults standardUserDefaults] setObject:_did forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)savekey{
    NSDateFormatter *formart = [[NSDateFormatter alloc] init];
    formart.dateStyle = NSDateFormatterShortStyle;
    return [formart stringFromDate:[NSDate date]];
    
}




@end
