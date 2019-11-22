//
//  EBannerView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 8/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import "EPageView.h"

NS_ASSUME_NONNULL_BEGIN


@interface EBannerView : EPageView

@property(nonatomic,assign)BOOL autoScroll;                       ///> 是否自动滚动
@property(nonatomic,assign)CGFloat autoScrollTimeInterval;        ///> 是否自动滚动时间，默认3s
@property(nonatomic,retain,readonly)UIPageControl *pageControl;   ///> 分页控价
@property(nonatomic,copy)NSString *registerCell;                  ///> 注册用的cell，nil=默认

- (void)reloadWithImages:(NSArray<ECellImageModel> *)images;

@end

NS_ASSUME_NONNULL_END
