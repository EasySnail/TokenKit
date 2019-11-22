//
//  EDataPicker.h
//  EServiceSDK
//
//  Created by 葛少玉 on 12/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <EServiceSDK/EServiceSDK.h>
#import "EBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EDataPickerDataProtocol <NSObject>
@optional
- (NSString *)name;

@end

@interface EDataPicker : EBaseAlertView

@property(nonatomic,retain)NSArray *dataArray;
@property(nonatomic,copy)void(^didSelectBlock)(NSInteger index, id data);

- (instancetype)initWithArray:(NSArray *)array handler:(void (^)(NSInteger index,id data))handler;

@end

NS_ASSUME_NONNULL_END
