//
//  TKBackUpInputPasswordView.h
//  TokenCard
//
//  Created by easy on 2019/5/22.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKBackUpInputPasswordView : UIView
@property(nonatomic,copy)void(^cancelHandler)(__nullable id data);
- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type;
- (void)reset;
- (void)setPswError:(NSString *)error;
@end

@interface TokenPhoneCode : UIControl

@property(nonatomic,retain)UILabel *label;
- (void)requestWithPhone:(NSString *)phone;
- (void)reset;
@end


NS_ASSUME_NONNULL_END
