//
//  EDefaultServiceMaker.h
//  EServiceSDK
//
//  Created by 葛少玉 on 20/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EServiceMaker [EDefaultServiceMaker sharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface EDefaultServiceMaker : NSObject

@property(nonatomic,retain)UIImage *backImage;                      ///<返回按钮
@property(nonatomic,retain)UIImage *placeholderImage;               ///<图片暂未图

+ (instancetype)sharedInstance;
- (void)make_service:(void(^)(EDefaultServiceMaker *make))block;    ///<初始化一些数据

@end

NS_ASSUME_NONNULL_END
