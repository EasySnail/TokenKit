//
//  NSString+ECategory.h
//  EServiceSDK
//
//  Created by 葛少玉 on 15/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ECategory)

- (CGFloat)e_widthWithFont:(UIFont *)font;
- (CGFloat)e_heightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)e_SizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
