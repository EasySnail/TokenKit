//
//  TKNavigationBar.h
//  TokenKit
//
//  Created by easy on 2019/12/6.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKNavigationBar : UIView

@property(nonatomic,retain,readonly)UILabel *titleLabel;

@property(nonatomic,retain,readonly)UIControl *backItem;


@end

NS_ASSUME_NONNULL_END
