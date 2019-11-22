//
//  UIColor+ECategory.h
//  EServiceSDK
//
//  Created by 葛少玉 on 19/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EColorData;

@interface UIColor (ECategory)

- (EColorData *)e_colorData;
+ (UIColor *)e_colorWithBeginColor:(EColorData *)bcolor endColor:(EColorData *)ecolor progress:(CGFloat)p;

@end



@interface EColorData : NSObject
@property(nonatomic,assign)CGFloat r;
@property(nonatomic,assign)CGFloat g;
@property(nonatomic,assign)CGFloat b;
@property(nonatomic,assign)CGFloat a;
@end
NS_ASSUME_NONNULL_END
