//
//  TKBackUpSecretKeyView.h
//  TokenCard
//
//  Created by easy on 2019/5/22.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKBackUpSecretKeyView : UIView


+ (void)showWithDid:(NSString *)did handler:(void(^)(BOOL success))handler;

+ (void)showPasswordViewWithDid:(NSString *)did handler:(void(^)(BOOL success))handler;

@end

NS_ASSUME_NONNULL_END
