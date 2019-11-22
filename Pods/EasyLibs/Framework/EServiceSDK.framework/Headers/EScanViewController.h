//
//  EScanViewController.h
//  ScanManager
//
//  Created by Easy on 2017/12/27.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ScanExtend.h"
#import "EScanManager.h"

@interface EScanViewController : UIViewController

@property(nonatomic,retain)EScanManager *cameraManager;

- (void)startSession;                                //开始
- (void)stopSession;                                 //结束


- (AVCaptureSessionPreset)sessionPreset;            //图质量

@end
