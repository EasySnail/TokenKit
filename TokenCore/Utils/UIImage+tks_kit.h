//
//  UIImage+tks_kit.h
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (tks_kit)

+ (UIImage *)token_image:(NSString *)name;

-(void)save:(void (^)(BOOL success))handler;

+ (UIImage *)barCodeImageWithCode:(NSString *)code size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
