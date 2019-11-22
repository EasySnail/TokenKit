//
//  TKAuthenticationCodeCell.h
//  TokenCard
//
//  Created by easy on 2019/5/27.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKHeader.h"

NS_ASSUME_NONNULL_BEGIN




@interface TKTextFieldModel : NSObject
@property(nonatomic,copy)NSString *resuCell;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,copy)NSString *value;                   ///< 显示值
@property(nonatomic,copy,nullable)NSString *v_value;                   ///< 真实值，默认=value
@property(nonatomic,assign)NSInteger keyboardType;          ///< 0=默认，1=数字
@property(nonatomic,assign)NSInteger extraType;             ///< 额外字段
@property(nonatomic,assign)NSInteger maxLength;
@property(nonatomic,assign)BOOL titleRequired;       ///< title 后面的红*
@property(nonatomic,assign)BOOL disabled;           ///< true,不可编辑


+ (TKTextFieldModel *)phoneModel;

+ (TKTextFieldModel *)codeModel;

@end



@interface TKAuthenticationTextFieldCell : UITableViewCell
- (instancetype)initWithType:(NSInteger)type;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)TKTextField *textField;
@property(nonatomic,weak)TKTextFieldModel *model;
- (void)updateData:(id)data;
@end


@interface TKAuthenticationCodeCell : TKAuthenticationTextFieldCell
- (void)codeTimerStart:(BOOL)start;
@property(nonatomic,assign)BOOL autoRemove;
@end



@interface TKTextFieComonCell : UITableViewCell
@property(nonatomic,retain,readonly)TKTextField *textField;
@property(nonatomic,strong)TKTextFieldModel *model;
- (void)updateData:(id)data;
@end



@interface TKTextFieldCodeComonCell : TKTextFieComonCell
- (void)codeTimerStart:(BOOL)start;
- (void)updateData:(id)data;
@end







NS_ASSUME_NONNULL_END
