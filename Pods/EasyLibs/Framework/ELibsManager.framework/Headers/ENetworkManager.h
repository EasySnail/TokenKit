//
//  ENetworkManager.h
//  ELibsManager
//
//  Created by 葛少玉 on 5/3/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EResponseData.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EHTTPMethod) {
    E_GET = 0,
    E_POST,
    E_DELETE
};

typedef void(^ProgressHandler)(NSProgress *progress);
typedef void(^ResponseHandler)(EResponseData *responseHandler);

@interface ENetworkManager : NSObject

@property(nonatomic,assign)NSTimeInterval timeoutInterval;                          ///< 请求超时时间 10s
@property(nonatomic,copy)NSString *baseURL;                                         ///< baseURL
@property(nonatomic,assign)EHTTPMethod method;                                      ///< 请求方式 默认get
@property(nonatomic,copy)NSString *url;                                             ///< 请求接口
@property(nonatomic,retain)NSDictionary *param;                                     ///< 请求参数
@property(nonatomic,copy)ProgressHandler progressHandler;                           ///< 数据进度
@property(nonatomic,copy)ResponseHandler responseHandler;                           ///< 请求结果响应
@property(nonatomic,copy)void(^parsingResponse)(EResponseData *response);           ///< 解析结果
@property(nonatomic,retain)NSMutableDictionary *requestHeaders;                     ///< 请求头内容
- (instancetype)initWithBaseURL:(NSString *)baseURL;
- (void)request;                                                                    ///< 开始请求
- (void)uploadFile;                                                                

///< 参数自定义解析格式
@property(nonatomic,copy)NSString *(^queryStringSerialization)(NSURLRequest *, id, NSError *__autoreleasing *);
@end

NS_ASSUME_NONNULL_END
