//
//  TKResetPasswordStepCell.h
//  TokenKit
//
//  Created by easy on 2019/11/15.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKResetPasswordStepCell : UITableViewCell<EListViewProtocol>
- (void)updateData:(NSDictionary *)data step:(NSInteger)step;
@end

NS_ASSUME_NONNULL_END
