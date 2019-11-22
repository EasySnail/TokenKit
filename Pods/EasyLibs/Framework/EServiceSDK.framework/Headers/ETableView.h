//
//  ETableView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 2/1/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EListViewMaker.h"


NS_ASSUME_NONNULL_BEGIN

@interface ETableView : UITableView

- (void)make_delegate:(void(^)(ETableViewMaker *make))block;

@end



NS_ASSUME_NONNULL_END

