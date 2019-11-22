//
//  TokenAuthDetailCell.m
//  TokenKit
//
//  Created by easy on 2019/11/8.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TokenAuthDetailCell.h"
#import "TKHeader.h"

@interface TokenAuthDetailCell()

@end

@implementation TokenAuthDetailCell

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
    
    UIView *sline = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 3, 15)];
    sline.backgroundColor = ERGBColor(0x00C1CE);
    sline.layer.cornerRadius = 1.5;
    [self.contentView addSubview:sline];
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 200, 45)];
    titleLb.text = @"认证详情如下";
    titleLb.font = [UIFont boldSystemFontOfSize:16];
    titleLb.textColor = ERGBColor(0x374F66);
    [self.contentView addSubview:titleLb];
    CGFloat dy = 50;
    NSArray *titles = @[@"上链序号：",@"上链状态：",@"块：",@"时间戳：",@"从：",@"至："];
    for (int i = 0; i < titles.count; ++i) {
        TokenAuthDetailCellItemView *v = [[TokenAuthDetailCellItemView alloc] initWithFrame:CGRectMake(0, dy, EWidth, 65) style:i == 1 title:titles[i]];
        dy += 65;
        [self.contentView addSubview:v];
        
        [v updateData:@"0x0c8f89da9"];
    }
    
}

- (void)updateData:(id)data{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)e_cellHeight{
    return 6*65+50;
}

@end










@implementation TokenAuthExplainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}
- (void)initView{
    UIImageView *headView = [[UIImageView alloc] initWithImage:[UIImage token_image:@"token_user_head_image"]];
    [self.contentView addSubview:headView];
    UIImageView *levelImg = [[UIImageView alloc] initWithImage:[UIImage token_image:@"token_auth_level2"]];
    [headView addSubview:levelImg];
    UILabel *textLb = [[UILabel alloc] init];
    textLb.numberOfLines  = 3;
    textLb.text = @"说明: V标代表了业务人员已经完成了姓名、身份证号认证,受经销商邀请授权,获得的标志证明";
    textLb.font = [UIFont systemFontOfSize:15];
    textLb.textColor = ERGBColor(0x374F66);
    [self.contentView addSubview:textLb];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = ERGBColor(0xf1f1f1);
    [self.contentView addSubview:line];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).centerOffset(CGPointMake(0, -3));
        make.left.mas_equalTo(15);
    }];
    
    [levelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-5);
    }];
    
    [textLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_right).offset(10);
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(headView);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(6);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}
- (CGFloat)e_cellHeight{
    return 100;
}
@end







@interface TokenAuthDetailCellItemView()
@property(nonatomic,assign)NSInteger style;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UIButton *button;
@end
@implementation TokenAuthDetailCellItemView

- (instancetype)initWithFrame:(CGRect)frame style:(NSInteger)style title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 35)];
        titleLabel.textColor = ERGBColor(0x374F66);
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.height-0.5, self.width-30, 0.5)];
        line.backgroundColor = ERGBColor(0xf1f1f1);
        [self addSubview:line];
        
        if (_style == 0) {
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabel.height, self.width-40, 20)];
            _label.font = [UIFont systemFontOfSize:13];
            _label.textColor = ERGBColor(0x737785);
            [self addSubview:_label];
        }else{
            self.button = [[UIButton alloc] initWithFrame:CGRectMake(20, titleLabel.height, 50, 22)];
            _button.titleLabel.font = [UIFont systemFontOfSize:11];
            _button.layer.cornerRadius = 2;
            _button.adjustsImageWhenHighlighted = false;
            _button.layer.masksToBounds = true;
            [self addSubview:_button];
            [self updateData:@"1"];
        }
    }
    return self;
}

- (void)updateData:(id)data{
    if (_style == 1) {
        int state = [NSString stringWithFormat:@"%@",data].intValue;
        if (state == 1) {
            //成功
            [self.button setTitle:@" 成功 " forState:UIControlStateNormal];
            [self.button setTitleColor:ERGBColor(0x52C41B) forState:UIControlStateNormal];
            self.button.backgroundColor = ERGBAColor(0x52C41B, 0.1);
            [self.button setImage:[UIImage token_image:@"token_state_success"] forState:UIControlStateNormal];
        }else if(state == 0){
            //处理中
        }else{
            //失败
        }
    }else{
        self.label.text = data;
    }
}

@end
