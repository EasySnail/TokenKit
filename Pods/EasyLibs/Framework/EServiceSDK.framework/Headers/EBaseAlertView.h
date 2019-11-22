//
//  EBaseAlertView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 1/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, EAlertAnimationStyle) {
    EAlertAnimationStyleNone = 0,
    EAlertAnimationStyleCenter,
    EAlertAnimationStyleBottom,
};


@interface EBaseAlertView : UIView

@property(nonatomic,weak)UIView *fromView;                          ///< 在那个界面显示，默认window

@property(nonatomic,assign)EAlertAnimationStyle style;
@property(nonatomic,retain,readonly)UIView *backgroundView;

- (void)show;
- (void)hide:(BOOL)animation;
- (void)animateWithState:(NSInteger)state;                          ///< 0=开始，1=动画中，

- (CGFloat)bottomSafeHeight;

@end

NS_ASSUME_NONNULL_END
