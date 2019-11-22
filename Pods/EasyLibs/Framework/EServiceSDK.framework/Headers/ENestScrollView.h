//
//  ENestScrollView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 26/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ENestScrollViewMaker;

typedef enum : NSUInteger {
    EBouncesTypeHeader,     ///< header头部弹性
    EBouncesTypeContent     ///< 内容头部弹性
} ENestBouncesType;

@protocol EHeaderScrollProtocol <NSObject>
@optional
- (void)didScroll:(UIScrollView *)scrollView dy:(CGFloat)dy;
@end

@interface ENestScrollView : UIView

@property(nonatomic,retain,readonly)UIScrollView *scrollView;
- (void)makeView:(void(^)(ENestScrollViewMaker *make))block;

@end

@interface ENestScrollViewMaker : NSObject

@property(nonatomic,assign)CGFloat stayHeight;                        ///< header停留高度   默认：0
@property(nonatomic,assign)ENestBouncesType bouncesType;              ///< 默认header头部弹性
@property(nonatomic,retain)UIView *contentView;                       ///< 滚动的view
@property(nonatomic,retain)UIView<EHeaderScrollProtocol> *headerView; ///< 头部的view
@property(nonatomic,retain)NSArray *gestureScrollViews;              ///< 同时响应滚动的视图 默认:contentView和它的subviews

@end

@interface ENScrollView : UIScrollView

@property(nonatomic,weak)NSArray *gestureViews;
@property(nonatomic,weak)UIScrollView *currenSubScrollView;

@end

NS_ASSUME_NONNULL_END
