//
//  EDatePicker.h
//  BNXRWorkApp
//
//  Created by Easy on 2017/7/19.
//  Copyright © 2017年 胡欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDatePicker : UIView
@property(nonatomic,retain)UIDatePicker *datePicker;
@property(nonatomic,copy)NSString *dateFormat;
@property(nonatomic,copy)void(^selectTimeBlock)(NSString *strDate,NSDate *date);


- (void)showPicker;
- (void)hidePicker:(BOOL)animation;
@end
