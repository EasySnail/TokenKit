//
//  EWebViewController.h
//  EServiceSDK
//
//  Created by 葛少玉 on 27/12/18.
//  Copyright © 2018年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EWebViewController : UIViewController

@property(nonatomic,copy)NSString *url;
@property(nonatomic,retain,readonly)EWebView *webView;

- (instancetype)initWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
