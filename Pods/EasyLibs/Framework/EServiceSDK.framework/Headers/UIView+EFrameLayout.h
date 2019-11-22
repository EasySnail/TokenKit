//
//  UIView+EFrameLayout.h
//  EServiceSDK
//
//  Created by 葛少玉 on 19/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (EFrameLayout)

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;

- (UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
