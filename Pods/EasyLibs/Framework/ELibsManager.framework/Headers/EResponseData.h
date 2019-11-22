//
//  EResponseData.h
//  ELibsManager
//
//  Created by easy on 2019/5/20.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EApiStatus) {
    EApiStatusSuccess = 0,
    EApiStatusErr = 1,
    EApiStatusNoNetwork = -1,
    EApiStatusNetworkErr = -2,
};


@interface EResponseData : NSObject
@property(nonatomic,assign)EApiStatus status;
@property(nonatomic,assign,readonly)BOOL success;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,retain)NSError *error;
@property(nonatomic,retain,readonly)id data;
@property(nonatomic,retain)id responseObj;
@property(nonatomic,retain)id body;

@property(nonatomic,copy)id(^modelWithData)(id data);   ///< 解析类型

@end

NS_ASSUME_NONNULL_END
