//
//  UIViewController+EAlert.h
//  EServiceSDK
//
//  Created by 葛少玉 on 30/1/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (EAlert)

- (void)alertMessage:(NSString *)message;
- (void)alertMessage:(NSString *)message actions:(NSArray *)actions handler:(void(^ __nullable)(NSInteger index))handler;

- (void)alertActionSheet:(NSArray *)actions handler:(void(^)(NSInteger index))handler;

@end

NS_ASSUME_NONNULL_END
