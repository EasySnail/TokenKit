//
//  ReceiveViewController.h
//  TokenKit
//
//  Created by easy on 2019/11/19.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextFieldController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReceiveViewController : BaseTextFieldController

@end

@interface ReceiveListCell : UITableViewCell
- (void)updateData:(id)data;
@end


NS_ASSUME_NONNULL_END
