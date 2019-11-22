//
//  TKResetPasswordStepCell.m
//  TokenKit
//
//  Created by easy on 2019/11/15.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKResetPasswordStepCell.h"

@interface TKResetPasswordStepCell()

@property(nonatomic,retain)UIProgressView *progress;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)NSMutableArray<UIButton *> * buttons;
@end

@implementation TKResetPasswordStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(ViewScale(50), 45, EWidth-ViewScale(100), 2)];
    _progress.transform = CGAffineTransformMakeScale(1, 3);
    [self.contentView addSubview:_progress];
    _progress.progressTintColor = ERGBColor(0x00C1CE);
    _progress.trackTintColor = ERGBColor(0xE5E5E5);
    
    CGFloat dpx = 0.1*_progress.width;
    NSArray *dpxs = @[@(_progress.x+dpx),@(_progress.x+dpx*5),@(_progress.x+dpx*9)];
    self.buttons = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(((NSNumber *)dpxs[i]).floatValue-13, _progress.centerY-13, 26, 26)];
        bt.layer.cornerRadius = 13;
        bt.layer.masksToBounds = true;
        bt.layer.borderWidth = 0.5;
        bt.tag = i;
        bt.titleLabel.font = [UIFont systemFontOfSize:15];
        [bt setTitle:[NSString stringWithFormat:@"%@",@(i+1)] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt setTitleColor:ERGBColor(0x00C1CE) forState:UIControlStateSelected];
        [self.contentView addSubview:bt];
        [self buttonAdjustState:bt];
        [self.buttons addObject:bt];
    }
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, EWidth, self.e_cellHeight-80)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = ERGBColor(0x374F66);
    _titleLabel.numberOfLines = 3;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
}

- (void)updateData:(NSDictionary *)data step:(NSInteger)step{
    NSString *str = [NSString stringWithFormat:@"您已经完成了第%@次密码验证,\n本次验证服务由%@提供。",@(step),data[@"name"]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 5;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    self.titleLabel.attributedText = att;
    
    for (UIButton *bt in self.buttons) {
        bt.selected = bt.tag < step;
        [self buttonAdjustState:bt];
    }
    if (step == 0) {
        self.progress.progress = 0;
    }else if (step == 1){
        self.progress.progress = 0.1;
    }else if (step == 2){
        self.progress.progress = 0.5;
    }else if (step == 3){
        self.progress.progress = 0.9;
    }
}

- (void)buttonAdjustState:(UIButton *)bt{
    if (bt.state == UIControlStateNormal) {
        bt.backgroundColor = ERGBColor(0xE5E5E5);
        bt.layer.borderColor = bt.backgroundColor.CGColor;
    }else{
        bt.backgroundColor = [UIColor whiteColor];
        bt.layer.borderColor = self.progress.progressTintColor.CGColor;
    }
}

- (CGFloat)e_cellHeight{
    return 140;
}
@end
