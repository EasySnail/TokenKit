//
//  UIImage+tks_kit.m
//  TokenKit
//
//  Created by easy on 2019/11/7.
//  Copyright © 2019 easy. All rights reserved.
//

#import "UIImage+tks_kit.h"
#import "TokenUIApi.h"
#import <Photos/Photos.h>
#import "TKHeader.h"

@implementation UIImage (tks_kit)
+ (UIImage *)token_image:(NSString *)name{
    NSString *path = [[NSBundle bundleForClass:[TokenUIApi class]] pathForResource:@"Resource" ofType:@"bundle"];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",path,name];
    return [UIImage imageNamed:imagePath];
}


//获取之前的相册
-(PHAssetCollection *)fetchAssetCollection:(NSString *)AlbumTitle{
    //获取之前的相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil] ;
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:AlbumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

-(void)save:(void (^)(BOOL success))handler{
    UIImage *image = self;
    
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //判断之前有没有创建有没有去创建
        PHAssetCollection *assetCollection = [self fetchAssetCollection:executableFile] ;
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest ;
        if (assetCollection) {
            //已有相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection] ;
        }else{//没有相册
            //1.创建自定义相册assetCollectionChangeRequest
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:executableFile];
        }
        //2.添加图片到系统相册
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image] ;
        //3.拷贝图片到自定义相册（把图片的地址给自定义相册）
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset] ;
        [assetCollectionChangeRequest addAssets:@[placeholder]] ;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_main_async_safe(^{
            handler(success);
        });
    }];
}



+ (UIImage *)barCodeImageWithCode:(NSString *)code size:(CGSize)size{
    
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator" withInputParameters:@{@"inputMessage": codeData, @"inputQuietSpace": @.0}];
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setDefaults];
    [colorFilter setValue:filter.outputImage forKey:@"inputImage"];
    [colorFilter setValue:[CIColor colorWithRed:0.2 green:0.3 blue:0.4] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor1"];

    
    UIImage *outImage;
    if (size.width == 0.0 || size.height == 0.0) {
        outImage = [UIImage imageWithCIImage:colorFilter.outputImage];
    }else{
        CIImage *fimage = colorFilter.outputImage;
        CGRect integralRect = fimage.extent;
        CGImageRef imageRef = [[CIContext context] createCGImage:fimage fromRect:integralRect];
        //! 创建上下文
        CGFloat sideScale = fminf(size.width / integralRect.size.width, size.width / integralRect.size.height) * [UIScreen mainScreen].scale;
        size_t contextRefWidth = ceilf(integralRect.size.width * sideScale);
        size_t contextRefHeight = ceilf(integralRect.size.height * sideScale);
        CGContextRef contextRef = CGBitmapContextCreate(nil, contextRefWidth, contextRefHeight, 8, 0, CGColorSpaceCreateDeviceGray(), (CGBitmapInfo)kCGImageAlphaNone);
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
        CGContextScaleCTM(contextRef, sideScale, sideScale);
        CGContextDrawImage(contextRef, integralRect, imageRef);
        CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
        CGContextRelease(contextRef);
        CGImageRelease(imageRef);
        //! 将CGImageRefc转成UIImage
        outImage = [UIImage imageWithCGImage:scaledImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    }
    return outImage;
}
@end
