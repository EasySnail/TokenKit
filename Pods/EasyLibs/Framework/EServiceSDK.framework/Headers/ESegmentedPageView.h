//
//  ESegmentedPageView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 18/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESegmentedView.h"

NS_ASSUME_NONNULL_BEGIN
@class ESegmentedPageViewMaker;

@protocol ESegmentedPageItemView <NSObject>
@optional
- (NSString *)title:(NSInteger)index;
- (void)viewDidAppear:(NSInteger)index first:(BOOL)first;

@end

@interface ESegmentedPageView : UIView

@property(nonatomic,retain,readonly)ESegmentedPageViewMaker *make;
- (void)makePageView:(void(^)(ESegmentedPageViewMaker *make))block;

@end

@interface ESegmentedPageViewMaker : NSObject

@property(nonatomic,retain)NSArray<UIView<ESegmentedPageItemView> *> *itemViews;

@property(nonatomic,assign)ESegmentedViewStyle style;           ///< 排列类型
@property(nonatomic,assign)CGFloat margin_lf;                   ///< 左右边缘     default:0
@property(nonatomic,assign)CGFloat spacing;                     ///< 间距
@property(nonatomic,assign)CGFloat itemExtraWidth;              ///< text额外的宽度(除去text的真实宽度) default:5
@property(nonatomic,copy)NSString *registerCell;                ///< 自定义cell   default:ESegmentedViewCell
@property(nonatomic,retain)UIFont *font;                        ///< 字体大小     default:14
@property(nonatomic,retain)UIFont *selectFont;                  ///< 选中字体大小  default: font
@property(nonatomic,retain)UIColor *color;                      ///< 字体颜色     default:gray
@property(nonatomic,retain)UIColor *selectColor;                ///< 选中字体颜色  default:red
@property(nonatomic,assign)NSInteger index;                     ///< 当前位置

@property(nonatomic,retain)UIColor *backgroundColor;            ///< 背景颜色   default:0xfcfcfc
@property(nonatomic,retain)UIColor *borderColor;                ///< 边框颜色   default:0xcdcdcd

@property(nonatomic,assign)BOOL lineEnabled;                    ///< 下滑线，default：false
@property(nonatomic,assign)CGFloat lineWidth;                   ///< 线宽
@property(nonatomic,assign)CGFloat lineHeight;
@property(nonatomic,assign)CGFloat segmentedHeight;             ///< 头部高度



@end

NS_ASSUME_NONNULL_END
