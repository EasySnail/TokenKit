//
//  UIView+EHUD.h
//  ELibsManager
//
//  Created by 葛少玉 on 22/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

static const int EHideDelayTimer = 2;               ///<隐藏秒

@interface UIView (EHUD)

@property(nonatomic,retain)MBProgressHUD *e_hud;

- (void)e_showMessage:(NSString *)message;
- (void)e_showHudText:(NSString * _Nullable)text;
- (MBProgressHUD *)e_showHudProgress;
- (void)e_showHudImage:(UIImage * _Nullable)image text:(NSString *)text;
- (void)e_hideHud;

@end

NS_ASSUME_NONNULL_END
