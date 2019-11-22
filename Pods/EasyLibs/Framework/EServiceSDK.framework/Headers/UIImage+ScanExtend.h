//
//  UIImage+ScanExtend.h
//  ScanManager
//
//  Created by Easy on 2017/12/28.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScanExtend)

+ (UIImage *)imageWithCIImage:(CIImage *)ciimage fromOrect:(CGRect)orect contentRect:(CGRect)crect;
@end
