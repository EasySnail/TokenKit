//
//  TKPhotoPicker.m
//  TokenCard
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKPhotoPicker.h"
#import "TKHeader.h"
#import <TZImagePickerController/TZImagePickerController.h>

#define CircleCropRadius  ([UIScreen mainScreen].bounds.size.width*0.5)

@interface TKPhotoPicker()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,assign)NSInteger maxCount;
@property(nonatomic,assign)BOOL allowPickingGif;
@property(nonatomic,copy)void(^pickingPhotosBlock)(NSArray *photos);
@property(nonatomic,weak)UIViewController *viewController;

@property(nonatomic, retain) UIImagePickerController *imagePickerVc;
@end

@implementation TKPhotoPicker

//单张图
+ (instancetype)photoPicker{
    TKPhotoPicker *picker = [[TKPhotoPicker alloc] init];
    picker.allowCrop = true;
    picker.maxCount = 1;
    picker.allowPickingGif = false;
    return picker;
}
//多张图
+ (instancetype)photosPicker{
    TKPhotoPicker *picker = [[TKPhotoPicker alloc] init];
    picker.allowCrop = false;
    picker.maxCount = 9;
    picker.allowPickingGif = false;
    return picker;
}

- (void)pickingInController:(UIViewController *)controller handlerBlock:(void(^)(NSArray *photos))handler{
    self.viewController = controller;
    self.pickingPhotosBlock = handler;
}


- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.viewController.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.viewController.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

//相册
- (void)openPhotoAlbum{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:self];
    imagePickerVc.allowPickingVideo = false;
    imagePickerVc.allowPickingOriginalPhoto = false;
    imagePickerVc.allowTakePicture = false;
    imagePickerVc.allowPickingGif = self.allowPickingGif;
    if (self.maxCount == 1 && self.allowCrop) {
        imagePickerVc.allowCrop = true;
        imagePickerVc.scaleAspectFillCrop = true;
        if (CGRectEqualToRect(_cropRect,CGRectZero)) {
            imagePickerVc.circleCropRadius = CircleCropRadius;
        }else{
            imagePickerVc.cropRect = _cropRect;
        }
    }else if (self.maxCount == 1){
        imagePickerVc.allowCrop = false;
        imagePickerVc.showSelectBtn = false;
    }else{
        imagePickerVc.showSelectBtn = true;
    }
    [self.viewController presentViewController:imagePickerVc animated:YES completion:nil];
}
//相机
- (void)openCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.viewController  presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        [self openCameraSetting:0];
    }
}

- (void)openCameraSetting:(int)tag{
    [self.viewController alertMessage:@"无法使用相机,请在iPhone的""设置-隐私-相机""中允许访问相机" actions:@[@"确定"] handler:^(NSInteger index) {
        
    }];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        [tzImagePickerVc showProgressHUD];
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image = img;
        if (img.imageOrientation != UIImageOrientationUp) {
            UIGraphicsBeginImageContext(img.size);
            [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(PHAsset *asset, NSError *error) {
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                // NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:false allowPickingImage:true needFetchAssets:false completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (self.allowCrop) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                if (self.pickingPhotosBlock) {
                                    EPhotoModel *md = [[EPhotoModel alloc] initWithType:0 image:cropImage];
                                    self.pickingPhotosBlock(@[md]);
                                }
                            }];
                            //                            imagePicker.needCircleCrop = true;
                            if (CGRectEqualToRect(self.cropRect,CGRectZero)) {
                                imagePicker.circleCropRadius = CircleCropRadius;
                            }else{
                                imagePicker.cropRect = self.cropRect;
                            }
                            imagePicker.scaleAspectFillCrop = true;
                            [self.viewController presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            if (self.pickingPhotosBlock) {
                                EPhotoModel *md = [[EPhotoModel alloc] initWithType:0 image:image];
                                self.pickingPhotosBlock(@[md]);
                            }
                        }
                    }];
                }];
            }
        }];
    }
}


#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (self.pickingPhotosBlock) {
        NSMutableArray *array = [NSMutableArray array];
        for (UIImage *image in photos) {
            EPhotoModel *md = [[EPhotoModel alloc] initWithType:0 image:image];
            [array addObject:md];
        }
        self.pickingPhotosBlock(array);
    }
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset{
    if (self.pickingPhotosBlock) {
        EPhotoModel *md = [[EPhotoModel alloc] initWithType:1 image:animatedImage];
        md.asset = asset;
        self.pickingPhotosBlock(@[md]);
    }
}

@end






@implementation EPhotoModel
- (instancetype)initWithType:(int)type image:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.type = type;
        self.image = image;
    }
    return self;
}
@end
