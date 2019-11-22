//
//  UIView+TokenView.h
//  TokenSDK
//
//  Created by easy on 2019/10/24.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TokenView)


+ (UIView *)token_bottom_button:(id)target action:(SEL)action title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
