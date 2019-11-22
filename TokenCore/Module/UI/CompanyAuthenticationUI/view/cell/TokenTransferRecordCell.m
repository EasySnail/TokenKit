//
//  TokenTransferRecordCell.m
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TokenTransferRecordCell.h"
#import "TKHeader.h"
#import "TKTransferRecordModel.h"

@interface TokenTransferRecordCell()

@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *label3;
@property(nonatomic,retain)TKBarCodeView *codeView;

@end

@implementation TokenTransferRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)updateData:(TKTransferRecordModel *)data{
    self.label1.text = data.title;
    self.label2.text = data.name;
    self.label3.text = data.time;
    
    self.codeView.timeLabel.text = @"2019.01.01 12:22:06";
    self.codeView.dataLabel.text = data.txHash;
    WeakSelf
    [data codeImage:^(UIImage * _Nonnull image) {
        weakSelf.codeView.barImageView.image = image;
    }];
}

- (void)initView{
    UIImageView *lfImage = [[UIImageView alloc] initWithImage:[UIImage token_image:@"token_record_lf"]];
    [self.contentView addSubview:lfImage];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = ERGBColor(0xcccccc);
    [self.contentView addSubview:line];
    
    
    self.label1 = [[UILabel alloc] init];
    _label1.font = [UIFont boldSystemFontOfSize:15];
    _label1.textColor = ERGBColor(0x374F66);
    [self.contentView addSubview:_label1];
    
    self.label2 = [[UILabel alloc] init];
    _label2.font = [UIFont systemFontOfSize:15];
    _label2.textColor = ERGBColor(0x374F66);
    [self.contentView addSubview:_label2];
    
    self.label3 = [[UILabel alloc] init];
    _label3.font = [UIFont systemFontOfSize:13];
    _label3.textColor = ERGBColor(0x737785);
    [self.contentView addSubview:_label3];
    
    
    self.codeView = [[TKBarCodeView alloc] init];
    [self.contentView addSubview:_codeView];
    
    UILabel *yzlabel = [[UILabel alloc] init];
    yzlabel.text = @"验证";
    yzlabel.font = [UIFont systemFontOfSize:12];
    yzlabel.textColor = ERGBColor(0x737785);
    [self.contentView addSubview:yzlabel];

    UIImageView *imagev2 = [[UIImageView alloc] initWithImage:[UIImage token_image:@"token_record_sc"]];
    [self.contentView addSubview:imagev2];

    
    [lfImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.centerX.equalTo(lfImage);
        make.top.equalTo(lfImage.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lfImage.mas_right).offset(5);
        make.centerY.equalTo(lfImage);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lfImage.mas_right).offset(5);
        make.top.equalTo(self.label1.mas_bottom).offset(6);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lfImage.mas_right).offset(5);
        make.top.equalTo(self.label2.mas_bottom).offset(6);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
    
    
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2.mas_left);
        make.height.mas_equalTo(62);
        make.right.mas_offset(-45);
        make.bottom.mas_equalTo(-25);
    }];
    
    [yzlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeView.mas_right).offset(8);
        make.top.equalTo(self.codeView.mas_top).offset(5);
    }];

    [imagev2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(yzlabel);
        make.top.equalTo(yzlabel.mas_bottom).offset(5);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end






@implementation TKBarCodeView

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = ERGBColor(0x374F66);
        [self addSubview:_timeLabel];
        
        self.dataLabel = [[UILabel alloc] init];
        _dataLabel.font = [UIFont systemFontOfSize:9];
        _dataLabel.minimumScaleFactor = 0.5;
        _dataLabel.adjustsFontSizeToFitWidth = true;
        _dataLabel.textColor = ERGBColor(0x374F66);
        [self addSubview:_dataLabel];
        
        self.barImageView = [[UIImageView alloc] init];
        [self addSubview:_barImageView];

        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(5);
            make.height.mas_equalTo(15);
        }];
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-2);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(12);
        }];
        [_barImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(1);
            make.bottom.equalTo(self.dataLabel.mas_top).offset(-1);
        }];
    }
    return self;
}

@end
