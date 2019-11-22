//
//  EMacroHeader.h
//  EServiceSDK
//
//  Created by 葛少玉 on 14/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#ifndef EMacroHeader_h
#define EMacroHeader_h


/*** 屏幕device ***/

#define EWidth EAppConfigManager.screenWidth
#define EHeight EAppConfigManager.screenHeight
#define EISPhone EAppConfigManager.isPhone
#define EISPad EAppConfigManager.isPad
#define EDeviceId EAppConfigManager.deviceId
#define EISFringeScreen EAppConfigManager.isFringeScreen
#define ESafeBottomHeight EAppConfigManager.safeBottomHeight
#define EStatusBarHeight EAppConfigManager.statusBarHeight
#define ENavigationHeight EAppConfigManager.navigationHeight
#define ETabarHeight EAppConfigManager.tabarHeight
#define EKeyWindow [UIApplication sharedApplication].keyWindow

/*** 屏幕适配 ***/

#define ViewScale(px) (EISPhone ? iPhoneViewScale(px) : iPadViewScale(px))
#define iPadViewScale(px) ((EWidth > EHeight) ?(EWidth/768.0*(px)):(EWidth/1024.0*(px)))
#define iPhoneViewScale(px) ((EWidth < EHeight)?(EWidth/375.0*(px)):(EWidth/667.0*(px)))


/*** color ***/

#define EColor_red [UIColor redColor]
#define EColor_yellow [UIColor yellowColor]
#define EColor_white [UIColor whiteColor]
#define EColor_black [UIColor blackColor]
#define EColor_gray [UIColor grayColor]
#define EColor_lightGray [UIColor lightGrayColor]
#define ERGBAColor(value, alp) ([UIColor colorWithRed:(((value & 0xFF0000) >> 16))/255.0 green:(((value & 0xFF00) >> 8))/255.0 blue:((value & 0xFF))/255.0 alpha:alp])
#define ERGBColor(value) [UIColor colorWithRed:(((value & 0xFF0000) >> 16))/255.0 green:(((value & 0xFF00) >> 8))/255.0 blue:((value & 0xFF))/255.0 alpha:1.0]


/*** Weak-Self ***/

#define WeakSelf __weak typeof(self) weakSelf = self;


/*** function ***/

#define ETimestamp [EAppConfig timestamp]
#define EUniqueID [EAppConfig uuid]
#define ESafeString(str) (str == nil ? @"" : str)

#endif /* EMacroHeader_h */
