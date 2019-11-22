//
//  UIViewController+Enavigation.h
//  EServiceSDK
//
//  Created by 葛少玉 on 20/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, ENavigationBackType) {
    ENavigationBackTypeDefualt,
    ENavigationBackType1,                    ///< 返回最上一级，没有navigationTag标记的
    ENavigationBackType2,                    ///< 返回navigationTag标记的vc,没找到root
};

@interface UIViewController (Enavigation)

@property(nonatomic,assign)ENavigationBackType navigationBackType;

@property(nonatomic,assign)BOOL disableGestureBack;     ///< 是否禁止左滑返回
@property(nonatomic,copy)NSString *navigationTag;       ///< 导航标记，1=标记

- (void)e_setBackButton:(UIImage * __nullable)image;

- (void)e_popViewController;                           ///< 跳过标记，返回上一个界面，
- (void)e_popToTagViewController;                      ///< 返回到，navigationTag标记的界面，没有，就root


@end

NS_ASSUME_NONNULL_END
