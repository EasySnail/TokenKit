//
//  TKBackupPswTextFiedCell.m
//  TokenCard
//
//  Created by easy on 2019/6/16.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKBackupPswTextFiedCell.h"


@interface TKBackupPswTextFiedCell()

@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *eyeButton;

@end

@implementation TKBackupPswTextFiedCell

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

- (void)initView{
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textColor = ERGBColor(0x374F66);
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(25);
    }];
    self.textField = [[TKTextField alloc] initWithFrame:CGRectMake(0, 0, EWidth, 30)];
    _textField.maxLength = 20;
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-5);
    }];
    [self eyeButton];
}

- (void)buttonClick{
    [[self eyeButton] setImage:[UIImage token_image:self.eyeButton.tag == 0?@"token_eye_close":@"token_eye_open"] forState:UIControlStateNormal];
    self.textField.secureTextEntry = self.eyeButton.tag == 0;
    self.eyeButton.tag = self.eyeButton.tag == 0 ? 1: 0;
}

- (UIButton *)eyeButton{
    if (_eyeButton == nil) {
        _eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _eyeButton.tag = 0;
        [_eyeButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        self.textField.rightView = _eyeButton;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.textFieldDidChangeBlock = ^(UITextField * _Nonnull textField) {
            
        };
        [self  buttonClick];
    }
    return _eyeButton;
}

- (void)updateData:(id)data{
    self.titleLabel.text = data;
    self.textField.placeholder = [NSString stringWithFormat:@"请%@",data];
}
- (CGFloat)e_cellHeight{
    return 80;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
