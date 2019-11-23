//
//  TKTextField.h
//  TokenCard
//
//  Created by easy on 2019/5/28.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TKTextField : UITextField

@property(nonatomic,copy)void(^textFieldDidChangeBlock)(UITextField *textField);
@property(nonatomic,copy)void(^textFieldDidFinishedBlock)(UITextField *textField);
@property(nonatomic,copy)BOOL(^textFieldShouldReturnBlock)(UITextField *textField);
@property(nonatomic,copy)void(^textFieldDidEndEditingBlock)(UITextField *textField);

@property(nonatomic,assign)NSInteger maxLength;    ///< 最大长度



@end

NS_ASSUME_NONNULL_END
