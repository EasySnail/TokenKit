//
//  EScanManager.h
//  ScanManager
//
//  Created by Easy on 2017/12/27.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface EScanManager : NSObject

@property (nonatomic, strong)AVCaptureSession *captureSession;
@property (nonatomic, copy)AVCaptureSessionPreset sessionPreset;           //图片质量

@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;    //出流
@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput;       //输入流
@property(nonatomic,retain)AVCaptureVideoPreviewLayer *preLayer;            //显示

@property(nonatomic,copy)void(^didOutputSampleBufferHandelBlock)(CVPixelBufferRef imageBuffer);


+ (void)cameraAuthorization:(void (^)(BOOL))cameraAuthorization;            //相机权限

- (BOOL)configSession;                               //设置
- (void)startSession;                                //开始
- (void)stopSession;                                 //结束

- (BOOL)canSwitchCameras;                            //能否切换前置后置
- (BOOL)switchCameras;                               //切换

- (AVCaptureDevice *)activeCamera;
- (AVCaptureDevice *)inactiveCamera;                 //待用相机
- (AVCaptureFlashMode)flashMode;                     //闪光灯状态
- (void)setFlashMode:(AVCaptureFlashMode)flashMode;  //设置闪关灯状态


- (BOOL)cameraHasTorch;                              //有无手电筒
- (AVCaptureTorchMode)torchMode;                     //手电筒状态
- (void)setTorchMode:(AVCaptureTorchMode)torchMode;  //设置手电筒

- (BOOL)cameraSupportsTapToFocus;                    //能否调整焦距
- (void)focusAtPoint:(CGPoint)point;                 //设置焦距

@end
