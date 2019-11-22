//
//  UIImage+ECategory.h
//  EServiceSDK
//
//  Created by 葛少玉 on 20/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ECategory)

+ (UIImage *)e_default_backImage;

- (UIImage *)e_scaleToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
