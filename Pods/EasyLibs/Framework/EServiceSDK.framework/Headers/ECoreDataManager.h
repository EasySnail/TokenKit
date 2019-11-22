//
//  ECoreDataManager.h
//  EServiceSDK
//
//  Created by 葛少玉 on 14/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol ECoreDataModel <NSObject>
@optional
- (NSString *)e_data_uid_key;                   ///<数据的唯一ID的key，实现了插入相同key值，只会更新
- (void)e_data_encrypt;                         ///<加密
- (void)e_data_decrypt;                         ///<解密
@end



@interface ECoreDataManager : NSObject

+ (instancetype)sharedInstance;

/**
 * 添加
 * @data 数据
 * @entity 表名
 **/
- (void)insertData:(NSArray<id<ECoreDataModel>> *)data entity:(NSString *)entity handler:(void(^__nullable)(BOOL sc))handler;

/**
 * 查询
 * @sort example
 * @index 分页，-1全部，size：每页条数
 **/
- (void)queryDataWithPredicate:(NSPredicate * __nullable)predicate sortDescriptors:(NSArray *__nullable)sort index:(NSInteger)index size:(NSInteger)size modelClass:(NSString *)modelClass entity:(NSString *)entity handler:(void(^)(NSArray *array))handler;

/**
 * 删除
 * @data 数据
 * @entity 表名
 **/
- (void)deleteWithPredicate:(NSPredicate *)predicate entity:(NSString *)entity handler:(void(^__nullable)(BOOL sc))handler;

@end


NS_ASSUME_NONNULL_END
