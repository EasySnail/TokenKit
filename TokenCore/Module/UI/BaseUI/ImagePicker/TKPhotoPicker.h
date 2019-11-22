//
//  TKPhotoPicker.h
//  TokenCard
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKPhotoPicker : NSObject

@property(nonatomic,assign)BOOL allowCrop;

@property(nonatomic,assign)CGRect cropRect;         ///< 裁剪尺寸

+ (instancetype)photoPicker;
+ (instancetype)photosPicker;
- (void)pickingInController:(UIViewController *)controller handlerBlock:(void(^)(NSArray *photos))handler;

- (void)openCamera;                             //打开相机
- (void)openPhotoAlbum;                         //打开相册

@end


@interface EPhotoModel : NSObject
@property(nonatomic,retain)id asset;
@property(nonatomic,retain)UIImage *image;
@property(nonatomic,assign)int type;            //0=png, 1=gif,2=video
@property(nonatomic,copy)NSString *videoPath;

- (instancetype)initWithType:(int)type image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
