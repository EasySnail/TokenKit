//
//  ECardCropViewController.h
//  EServiceSDK
//
//  Created by easy on 2019/11/11.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScanViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ECardCropViewController : EScanViewController

@property(nonatomic,copy)void(^successBlock)(UIImage *image);

@end

NS_ASSUME_NONNULL_END
