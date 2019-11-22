//
//  ESegmentedView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 8/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ESegmentedViewMaker;
@class ESegmentedModel;

@interface ESegmentedView : UIView

@property(nonatomic,assign)BOOL disableSameClick;             ///< 相同的是否可以在点击
@property(nonatomic,assign)BOOL didSelectInHorizontally;      ///< 选中的时候，是否动画居中
@property(nonatomic,retain,readonly)UICollectionView *collectionView;
@property(nonatomic,retain,readonly)ESegmentedViewMaker *make;
@property(nonatomic,copy)BOOL(^didSelectIndexBlock)(NSInteger index);      ///< 返回true=本类不处理


- (void)makeSegmentedView:(void(^)(ESegmentedViewMaker *make))block;

- (void)seg_selectIndex:(NSInteger)index;

- (void)updateData:(NSArray *)array;


@end


typedef NS_ENUM(NSUInteger, ESegmentedViewStyle) {
    EContentDivide,         ///< 均分排列
    EContentLeft,           ///< 从左到右依次排列
};

@interface ESegmentedViewMaker : NSObject

@property(nonatomic,assign)ESegmentedViewStyle style;           ///< 排列类型
@property(nonatomic,assign)CGFloat margin_lf;                   ///< 左右边缘     default:0
@property(nonatomic,assign)CGFloat spacing;                     ///< 间距
@property(nonatomic,assign)CGFloat itemExtraWidth;              ///< text额外的宽度(除去text的真实宽度) default:5
@property(nonatomic,copy)NSString *registerCell;                ///< 自定义cell   default:ESegmentedViewCell
@property(nonatomic,retain)NSArray<NSString *> *array;          ///< 数据源
@property(nonatomic,retain)UIFont *font;                        ///< 字体大小     default:14
@property(nonatomic,retain)UIFont *selectFont;                  ///< 选中字体大小  default: font
@property(nonatomic,retain)UIColor *color;                      ///< 字体颜色     default:gray
@property(nonatomic,retain)UIColor *selectColor;                ///< 选中字体颜色  default:red
@property(nonatomic,assign)NSInteger index;                     ///< 当前位置

@property(nonatomic,retain)UIColor *backgroundColor;            ///< 背景颜色   default:0xfcfcfc
@property(nonatomic,retain)UIColor *borderColor;                ///< 边框颜色   default:0xcdcdcd

@property(nonatomic,assign)BOOL lineEnabled;                    ///< 下滑线，default：false
@property(nonatomic,assign)CGFloat lineWidth;                   ///< 线宽
@property(nonatomic,assign)CGFloat lineHeight;                  ///< 线高

@property(nonatomic,retain,readonly)NSArray<ESegmentedModel *> *dataArray;
@property(nonatomic,weak,readonly)UIView *view;


@end


@interface ESegmentedModel : NSObject

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)CGFloat textLength;

@end


NS_ASSUME_NONNULL_END
