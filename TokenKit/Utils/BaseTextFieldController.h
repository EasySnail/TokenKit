//
//  BaseTextFieldController.h
//  TokenKit
//
//  Created by easy on 2019/11/19.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTextFieldCell : UITableViewCell

@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,retain)UITextField *textField;

- (void)updateTitle:(NSString *)title;

@end


@interface BaseTextFieldController : UIViewController
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray<JTextFieldCell *> *dataArray;
@end

NS_ASSUME_NONNULL_END
