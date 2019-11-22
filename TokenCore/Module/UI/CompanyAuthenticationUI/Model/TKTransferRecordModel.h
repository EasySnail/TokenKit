//
//  TKTransferRecordModel.h
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKTransferRecordModel : NSObject

- (instancetype)initWithModel:(TokenGoodsItem *)model;

@property(nonatomic,retain)UIImage *codeImage;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *txHash;

- (void)codeImage:(void (^)(UIImage *image))handler;

@end

NS_ASSUME_NONNULL_END
