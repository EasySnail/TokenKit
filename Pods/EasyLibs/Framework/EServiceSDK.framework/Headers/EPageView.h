//
//  EPageView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 7/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class EPageViewMaker;

@protocol ECellImageModel <NSObject>
@optional
- (NSString *)imageUrl;
@end


@interface EPageView : UIView
@property(nonatomic,retain,readonly)UICollectionView *collectionView;
@property(nonatomic,retain,readonly)EPageViewMaker *make;
@property(nonatomic,copy)void(^didSelectRowBlock)(id data);                         ///> 选择回调
@property(nonatomic,copy)void(^didScrollToRowBlock)(NSInteger row);                 ///> 滚动到第几
- (void)makePage:(void(^)(EPageViewMaker *make))block;                              ///> 设置
- (void)pageViewScrollToIndex:(NSInteger)index animated:(BOOL)animated;             ///> 滚动到index
@end



@interface EPageViewMaker : NSObject
@property(nonatomic,copy)NSString *registerCell;
@property(nonatomic,retain)NSArray *dataArray;
@end



@interface EPageViewImageCell : UICollectionViewCell
@property(nonatomic,retain,readonly)UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
