//
//  EContentStatusView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 6/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EContentStatusItemView.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, EContentStatus) {
    EContentStatusNormal,
    EContentStatusNoData,
    EContentStatusNetworkError
};

@protocol EContentStatusViewDefaultProtocol <NSObject>

- (void)makeDefaultContentStatusView;

@end

@interface EContentStatusView : UIView

@property(nonatomic,assign)EContentStatus status;
@property(nonatomic,copy)void(^buttonClickHandler)(EContentStatus status);
- (void)makeDefaultStatusView;
- (void)makeViewForStatus:(EContentStatus)status handler:(void(^)(EContentStatusItemView *view))block;

@end


@interface UIView (EContentStatus)

@property(nonatomic,retain)EContentStatusView *e_contentStatusView;

@end


@interface UIViewController (EContentStatus)

- (EContentStatusView *)e_contentStatusView;

@end



NS_ASSUME_NONNULL_END
