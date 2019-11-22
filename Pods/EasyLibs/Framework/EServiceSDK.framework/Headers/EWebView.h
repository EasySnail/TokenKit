//
//  EWebView.h
//  EServiceSDK
//
//  Created by 葛少玉 on 27/12/18.
//  Copyright © 2018年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EWebView : WKWebView

@property(nonatomic,copy)void(^webViewDidStartNavigationBlock)(WKWebView *webView);
@property(nonatomic,copy)void(^webViewDidFinishNavigationBlock)(WKWebView *webView);
@property(nonatomic,copy,nullable)void(^webViewDidFailProvisionalNavigationBlock)(NSError *error);
@property(nonatomic,assign)BOOL progressEnabled;
@property(nonatomic,assign)CGFloat progressYOffset;

- (void)loadUrl:(NSString *)url;

//js调oc方法名Block
- (void)addScriptMessageHandlerNames:(NSArray *)names handler:(void(^)(NSString*name,id body))handler;

/*
 oc调用js方法
 [self evaluateJavaScript:@"callJsConfirm()" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
 }];
 */

@end

NS_ASSUME_NONNULL_END
