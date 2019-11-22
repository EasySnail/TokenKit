//
//  UIView+Eevent.h
//  EServiceSDK
//
//  Created by 葛少玉 on 19/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Eevent)

@property(nonatomic,copy,nullable)void(^e_handler)(__nullable id data);

@end

NS_ASSUME_NONNULL_END
