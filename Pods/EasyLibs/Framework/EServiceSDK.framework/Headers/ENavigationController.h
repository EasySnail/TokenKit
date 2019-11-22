//
//  ENavigationController.h
//  EServiceSDK
//
//  Created by 葛少玉 on 28/1/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ENavigationGestureProtocol <NSObject>

@optional
- (BOOL)shouldGestureBack;

@end

@interface ENavigationController : UINavigationController

@end



NS_ASSUME_NONNULL_END
