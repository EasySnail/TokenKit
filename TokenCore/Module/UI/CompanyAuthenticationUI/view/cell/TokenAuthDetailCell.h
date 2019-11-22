//
//  TokenAuthDetailCell.h
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EServiceSDK/EServiceSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface TokenAuthDetailCell : UITableViewCell<EListViewProtocol>

@end


@interface TokenAuthExplainCell : UITableViewCell<EListViewProtocol>

@end



@interface TokenAuthDetailCellItemView : UIView
//两种类型，文字与button
- (instancetype)initWithFrame:(CGRect)frame style:(NSInteger)style title:(NSString *)title;

- (void)updateData:(id)data;
@end

NS_ASSUME_NONNULL_END
