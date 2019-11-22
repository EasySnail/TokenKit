//
//  EListViewProtocol.h
//  EServiceSDK
//
//  Created by 葛少玉 on 24/1/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EListViewProtocol <NSObject>

@optional
- (void)updateData:(_Nullable id)data;

//tableView
+ (CGFloat)cellHeightWithData:(id)data;
+ (CGFloat)cellHeight;
- (CGFloat)e_cellHeight;
//collectionView
+ (CGSize)cellSize;
+ (CGSize)cellSizeWithData:(id)data;



@end

NS_ASSUME_NONNULL_END
