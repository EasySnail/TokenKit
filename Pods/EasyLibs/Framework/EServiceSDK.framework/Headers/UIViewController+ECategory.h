//
//  UIViewController+ECategory.h
//  EServiceSDK
//
//  Created by 葛少玉 on 28/1/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ECategory)

@property(nonatomic,copy)void(^e_handler)(__nullable id data);


- (UIViewController *)e_topViewController;

@end

NS_ASSUME_NONNULL_END
