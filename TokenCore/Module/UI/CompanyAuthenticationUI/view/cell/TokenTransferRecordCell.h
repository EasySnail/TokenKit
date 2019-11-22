//
//  TokenTransferRecordCell.h
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenTransferRecordCell : UITableViewCell

- (void)updateData:(id)data;

@end



@interface TKBarCodeView : UIView

@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UIImageView *barImageView;
@property(nonatomic,retain)UILabel *dataLabel;

@end

NS_ASSUME_NONNULL_END
