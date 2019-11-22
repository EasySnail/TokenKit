//
//  TKBackupTitleDetailCell.m
//  TokenCard
//
//  Created by easy on 2019/6/16.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBackupTitleDetailCell.h"
#import "TKHeader.h"

@interface TKBackupTitleDetailCell()
@property(nonatomic,retain)UILabel *titleLabel;

@property(nonatomic,assign)CGFloat textHeight;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,retain)UIButton *button;
@end

@implementation TKBackupTitleDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self) {
        self.type = type;
        if (type < 10) {
            self.titleLabel = [[UILabel alloc] init];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.font = TKSDKFont(13);
            self.titleLabel.textColor = ERGBColor(0xFF820E);
            [self.contentView addSubview:_titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(15);
                make.right.bottom.mas_equalTo(-15);
            }];
        }else if (type >= 10){
            self.button = [[UIButton alloc] initWithFrame:CGRectMake(EWidth-115, 0, 100, 35)];
            _textHeight = 40;
            [self.button setTitle:@"忘记身份密码?" forState:UIControlStateNormal];
            [self.button setTitleColor:ERGBColor(0xFF820E) forState:UIControlStateNormal];
            self.button.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_button];
        }
        
        if (_type == 0) {
            _titleLabel.text = @"温馨提示：身份密码将作为您链信宝的唯一身份凭证，用于领取您的区块链数字身份及保护您的数据安全。链信宝不存储您的任何密码信息，请放心设置。";
        }else if (_type == 1){
            _titleLabel.text = @"温馨提示：为了增强您的私域数据安全，身份密码采取了双重加密技术，分片存储在服务终端。因此，需要您多次获取并输入验证码才可完成重置密码操作。";
        }
        
        
    }
    return self;
}

- (void)buttonClick{
    if (self.e_handler) {
        self.e_handler(nil);
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (CGFloat)e_cellHeight{
    if (_textHeight <= 0) {
        _textHeight = 32 + [self.titleLabel.text e_SizeWithFont:_titleLabel.font maxSize:CGSizeMake(EWidth-30, 300)].height;
    }
    return _textHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


