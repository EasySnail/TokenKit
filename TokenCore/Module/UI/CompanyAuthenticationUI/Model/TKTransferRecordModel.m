//
//  TKTransferRecordModel.m
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKTransferRecordModel.h"
#import "UIImage+tks_kit.h"
#import "NSString+tks_time.h"
#import <EServiceSDK/EServiceSDK.h>


@interface TKTransferRecordModel()

@property(nonatomic,retain)TokenGoodsItem *goodsModel;

@property(nonatomic,copy)void(^handler)(UIImage *image);
@end
@implementation TKTransferRecordModel

+ (dispatch_queue_t)sharedQueue{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("barcode.queue", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

- (instancetype)initWithModel:(TokenGoodsItem *)model{
    self = [super init];
    if (self) {
        self.goodsModel = model;
    }
    return self;
}

- (NSString *)txHash{
    if (_txHash == nil) {
        _txHash = _goodsModel.txHash;
        if (_txHash.length <= 0) {
            _txHash = [NSString stringWithFormat:@"100022113131311311002%06d1234567899%06d123131456788655551122",arc4random()%100000,arc4random()%100000];
        }
    }
    return _txHash;
}

- (NSString *)time{
    if (_time == nil) {
        NSString *str =  (_goodsModel.state == 2) ? @"收货时间" : @"发货时间";
        _time = [NSString stringWithFormat:@"%@:%@",str,[_goodsModel.timestamp tks_timeStampToDate]];
    }
    return _time;
}
- (NSString *)title{
    if (_title == nil) {
        if (_goodsModel.state == 2){
            _title = [NSString stringWithFormat:@"%@ 已确认收到 %@ 的货物",_goodsModel.buyerName,_goodsModel.sellerName];
        }else{
            _title = [NSString stringWithFormat:@"%@ 已发货给 %@",_goodsModel.sellerName,_goodsModel.buyerName];
        }
    }
    return _title;
}
- (NSString *)name{
    if (_name == nil) {
        _name = [NSString stringWithFormat:@"物品名称:%@",_goodsModel.commodityName];
    }
    return _name;
}


- (void)codeImage:(void (^)(UIImage *image))handler{
    
    self.handler = handler;
    if (self.codeImage == nil) {
        dispatch_async([TKTransferRecordModel sharedQueue],^{
            NSString *code = self.txHash.tk_md5_key;
            self.codeImage = [UIImage barCodeImageWithCode:code size:CGSizeMake(200, 20)];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.handler) {self.handler(self.codeImage);}
            });
        });
    }else{
        if (self.handler) {self.handler(self.codeImage);}
    }
}
@end
