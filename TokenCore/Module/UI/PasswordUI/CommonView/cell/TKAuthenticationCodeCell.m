//
//  TKAuthenticationCodeCell.m
//  TokenCard
//
//  Created by easy on 2019/5/27.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKAuthenticationCodeCell.h"

@interface TKAuthenticationCodeCell()<EListViewProtocol>
@property(nonatomic,retain)UIButton *codeButton;
@property(nonatomic,retain,nullable)NSTimer *timer;

@end

@implementation TKAuthenticationCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateData:(id)data{
    [super updateData:data];
    [self codeButton];
}
- (void)codeClick:(id)sender{
//    [self.viewController.view endEditing:true];
    if (self.e_handler) {self.e_handler(self);}
    
}
- (UIButton *)codeButton{
    if (_codeButton == nil) {
        self.codeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _codeButton.frame = CGRectMake(0, 0, 80, 28);
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = TKSDKFont(13);
        _codeButton.layer.borderWidth = 1;
        _codeButton.layer.borderColor = ERGBColor(0x374F66).CGColor;
        _codeButton.layer.cornerRadius = 2;
        [_codeButton addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_codeButton setTitleColor:ERGBColor(0x374F66) forState:UIControlStateNormal];
        [_codeButton setTitleColor:ERGBColor(0x999999) forState:UIControlStateDisabled];
        
        [self.contentView addSubview:_codeButton];
        [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.textField.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 28));
            make.right.mas_equalTo(-15);
        }];
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-95);
        }];
        
        self.textField.clearButtonMode = UITextFieldViewModeNever;
    }
    return _codeButton;
}

//开始，停止验证码倒计时
- (void)codeTimerStart:(BOOL)start{
    if (start) {
        if (self.timer == nil) {
            __block int times = 60;
            WeakSelf
            self.codeButton.enabled = false;
            self.codeButton.layer.borderColor = ERGBColor(0x999999).CGColor;
            [self.codeButton setTitle:[NSString stringWithFormat:@"%d s",times--] forState:UIControlStateNormal];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
                [weakSelf.codeButton setTitle:[NSString stringWithFormat:@"%d s",times--] forState:UIControlStateNormal];
                if (times < 0) {
                    [weakSelf.timer invalidate];
                    weakSelf.timer = nil;
                    weakSelf.codeButton.enabled = true;
                    weakSelf.codeButton.layer.borderColor = ERGBColor(0x374F66).CGColor;
                    [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
            }];
        }
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.codeButton.enabled = true;
        self.codeButton.layer.borderColor = ERGBColor(0x374F66).CGColor;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (_autoRemove) {
        if (newSuperview == nil) {
            [self.timer invalidate];
            _timer = nil;
        }
    }
}

@end





@interface TKAuthenticationTextFieldCell()<EListViewProtocol,UITextFieldDelegate>
@property(nonatomic,assign)NSInteger type;  //0=不带toptitle,1=带toptitle;
@property(nonatomic,retain)UILabel *topTitleLabel;
@end
@implementation TKAuthenticationTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)updateData:(TKTextFieldModel *)data{
    self.model = data;
    self.textField.text = data.value;
    self.textField.placeholder = data.placeholder;
    self.textField.keyboardType = data.keyboardType == 1 ? UIKeyboardTypeASCIICapableNumberPad :UIKeyboardTypeDefault;
    self.textField.maxLength = data.maxLength;
    self.textField.enabled = !data.disabled;
    self.topTitleLabel.text = data.title;
}
- (CGFloat)e_cellHeight{
    return _type == 0 ? 50 : 80;
}

- (TKTextField *)textField{
    if (_textField == nil) {
        _textField = [[TKTextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tk_textfield_regular"]];
        //        _textField.rightViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_textField];
        WeakSelf
        _textField.textFieldDidEndEditingBlock = ^(UITextField * _Nonnull textField) {
            weakSelf.model.value = textField.text;
        };
        
        if (_type == 1) {
            self.topTitleLabel = [[UILabel alloc] init];
            _topTitleLabel.textColor = ERGBColor(0x374F66);
            _topTitleLabel.font = [UIFont boldSystemFontOfSize:15];
            [self.contentView addSubview:_topTitleLabel];
            [_topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(10);
                make.height.mas_equalTo(25);
            }];
        }
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            if (self.type == 0) {
                make.top.bottom.mas_equalTo(0);
            }else{
                make.bottom.mas_equalTo(0);
                make.top.equalTo(self.topTitleLabel.mas_bottom);
            }
        }];
    }
    return _textField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end



@implementation TKTextFieldModel

- (NSString *)v_value{
    if (_v_value == nil || [_v_value isEqualToString:@""]) {
        _v_value = _value;
    }
    return _v_value;
}

+ (TKTextFieldModel *)phoneModel{
    TKTextFieldModel *md = [[TKTextFieldModel alloc] init];
    md.title = @"手机号";
    md.placeholder = @"请输入您的手机号";
    md.keyboardType = 1;
    md.maxLength = 11;
    return md;
}

+ (TKTextFieldModel *)codeModel{
    TKTextFieldModel *md = [[TKTextFieldModel alloc] init];
    md.title = @"验证码";
    md.placeholder = @"请输入验证码";
    md.keyboardType = 1;
    md.maxLength = 6;
    return md;
}

@end





@interface TKTextFieldCodeComonCell()<EListViewProtocol>
@property(nonatomic,retain)UIButton *codeButton;
@property(nonatomic,retain,nullable)NSTimer *timer;
@end

@implementation TKTextFieldCodeComonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateData:(id)data{
    [super updateData:data];
    [self codeButton];
}
- (void)codeClick:(id)sender{
    [self.viewController.view endEditing:true];
    if (self.e_handler) {self.e_handler(self);}
    
}
- (UIButton *)codeButton{
    if (_codeButton == nil) {
        
        self.codeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _codeButton.frame = CGRectMake(5, 0, 80, 28);
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = TKSDKFont(13);
        _codeButton.layer.borderWidth = 1;
        _codeButton.layer.borderColor = ERGBColor(0x374F66).CGColor;
        _codeButton.layer.cornerRadius = 2;
        [_codeButton addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_codeButton setTitleColor:ERGBColor(0x374F66) forState:UIControlStateNormal];
        [_codeButton setTitleColor:ERGBColor(0x999999) forState:UIControlStateDisabled];
        
        UIView *codeBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 28)];
        [codeBg addSubview:_codeButton];
        self.textField.rightView = codeBg;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _codeButton;
}

//开始，停止验证码倒计时
- (void)codeTimerStart:(BOOL)start{
    if (start) {
        if (self.timer == nil) {
            __block int times = 60;
            WeakSelf
            self.codeButton.enabled = false;
            self.codeButton.layer.borderColor = ERGBColor(0x999999).CGColor;
            [self.codeButton setTitle:[NSString stringWithFormat:@"%d s",times--] forState:UIControlStateNormal];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
                [weakSelf.codeButton setTitle:[NSString stringWithFormat:@"%d s",times--] forState:UIControlStateNormal];
                if (times < 0) {
                    [weakSelf.timer invalidate];
                    weakSelf.timer = nil;
                    weakSelf.codeButton.enabled = true;
                    self.codeButton.layer.borderColor = ERGBColor(0x374F66).CGColor;
                    [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
            }];
        }
    }else{
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        [self.timer invalidate];
        _timer = nil;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@interface TKTextFieComonCell()<EListViewProtocol>
@property(nonatomic,retain,readwrite)TKTextField *textField;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *requiredLabel;

@end

@implementation TKTextFieComonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (CGFloat)e_cellHeight{
    return 50;
}

- (void)updateData:(id)data{
    self.model = data;
    self.nameLabel.text = _model.title;
    self.textField.enabled = !_model.disabled;
    self.textField.text = _model.value;
    self.textField.placeholder = _model.placeholder;
    self.textField.keyboardType = _model.keyboardType == 1 ? UIKeyboardTypeASCIICapableNumberPad :UIKeyboardTypeDefault;
    self.textField.maxLength = _model.maxLength;
    self.requiredLabel.hidden = !_model.titleRequired;
}

- (TKTextField *)textField{
    if (_textField == nil) {
        _textField = [[TKTextField alloc] init];
        //_textField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tk_textfield_regular"]];
        //        _textField.rightViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_textField];
        _textField.textAlignment = NSTextAlignmentRight;
        WeakSelf
        _textField.textFieldDidEndEditingBlock = ^(UITextField * _Nonnull textField) {
            weakSelf.model.value = textField.text;
            weakSelf.model.v_value = nil;
        };
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(150);
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _textField;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = ERGBColor(0x374F66);
        _nameLabel.font = TKSDKFont(15);
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(15);
        }];
        
        
        self.requiredLabel = [[UILabel alloc] init];
        _requiredLabel.text = @"*";
        _requiredLabel.font = TKSDKFont(15);
        _requiredLabel.textColor = ERGBColor(0xFA4343);
        [self.contentView addSubview:_requiredLabel];
        [_requiredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(8, 10));
            make.left.equalTo(self.nameLabel.mas_right);
            make.top.equalTo(self.nameLabel.mas_top);
        }];
    }
    return self;
}
@end
