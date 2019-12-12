//
//  TKNavigationBar.m
//  TokenKit
//
//  Created by easy on 2019/12/6.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKNavigationBar.h"
#import "TKHeader.h"

@interface TKNavigationBar()
@property(nonatomic,retain,readwrite)UILabel *titleLabel;
@property(nonatomic,retain,readwrite)UIControl *backItem;
@end

@implementation TKNavigationBar


- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, EWidth, ENavigationHeight)];
    if (self) {
        self.backgroundColor = ERGBColor(0x00C1CE);
    }
    return self;
}



- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self).centerOffset(CGPointMake(0, EStatusBarHeight*0.5));
            make.width.mas_lessThanOrEqualTo(EWidth-120);
        }];
    }
    return _titleLabel;
}

- (UIControl *)backItem{
    if (_backItem == nil) {
        UIButton *back = [[UIButton alloc] init];
        [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        back.adjustsImageWhenHighlighted = false;
        [self addSubview:back];
        _backItem = back;
        [_backItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, ENavigationHeight-EStatusBarHeight));
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(EStatusBarHeight);
        }];
    }
    return _backItem;
}


@end


