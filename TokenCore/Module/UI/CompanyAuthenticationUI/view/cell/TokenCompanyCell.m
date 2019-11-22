//
//  TokenCompanyCell.m
//  TokenSDK
//
//  Created by easy on 2019/10/28.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TokenCompanyCell.h"

@implementation TokenCompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end



@interface TokenCompanyCertificationTitleCell()
@property(nonatomic,retain)NSArray<UIButton *> *segments;
@property(nonatomic,retain)NSArray *titles;
@end
@implementation TokenCompanyCertificationTitleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)updateData:(id)data{
    self.titles = data;
    [self segments];
}

- (void)buttonClick:(UIButton *)bt{
    for (UIButton *button in _segments) {
        button.selected = button == bt;
    }
    if (self.e_handler) {
        self.e_handler(@(bt.tag));
    }
}

- (NSArray<UIButton *> *)segments{
    if (_segments == nil) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EWidth, 5)];
        line.backgroundColor = ERGBColor(0xf1f1f1);
        [self.contentView addSubview:line];
        NSMutableArray *array = [NSMutableArray array];
        UIView *tempView = nil;
        for (int i = 0; i < _titles.count; ++i) {
            CGFloat dw = [_titles[i] e_SizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(200, 40)].width + 18;
            UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(10+tempView.width+tempView.x, 10, dw, 40)];
            [bt setTitle:[NSString stringWithFormat:@" %@",_titles[i]] forState:UIControlStateNormal];
            bt.titleLabel.font = TKSDKFont(14);
            [bt setTitleColor:ERGBColor(0x374f66) forState:UIControlStateNormal];
            [bt setImage:[UIImage token_image:@"token_unchecked"] forState:UIControlStateNormal];
            [bt setImage:[UIImage token_image:@"token_checked"] forState:UIControlStateSelected];
            bt.tag = i;
            [bt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:bt];
            tempView = bt;
            [array addObject:bt];
        }
        _segments = array;
        _segments[0].selected = true;
    }
    return _segments;
}
- (CGFloat)e_cellHeight{
    return 50;
}

@end





@interface TokenCompanyLetterCell()
@property(nonatomic,copy)NSString *did;
@property(nonatomic,retain)UIImageView *letterImage;
@property(nonatomic,retain)TKPhotoPicker *photoPicker;
@end

@implementation TokenCompanyLetterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat dw = EWidth-ViewScale(40);
        UIView *pdfView = [[UIView alloc] initWithFrame:CGRectMake(ViewScale(20), 0, dw, 1.415*dw+60+44+15)];
        pdfView.layer.borderColor = ERGBColor(0xCCCCCC).CGColor;
        pdfView.layer.borderWidth = 0.5;
        [self.contentView addSubview:pdfView];
        
        self.letterImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, pdfView.width-2, 1.415*dw-2)];
        _letterImage.contentMode = UIViewContentModeScaleAspectFit;
        [pdfView addSubview:_letterImage];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, _letterImage.height+_letterImage.y, pdfView.width-15, 60)];
        label.text = @"备注：请下载以上模板（或手抄以上内容），填写并加盖 公章，拍照后上传（照片清晰可见）日期和签字必须为手 写，内容真实有效";
        label.textColor = ERGBColor(0xFF820E);
        label.font = TKSDKFont(12);
        label.numberOfLines = 3;
        [pdfView addSubview:label];

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ViewScale(18), label.height+label.y+5, ViewScale(115), 44)];
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(pdfView.width-ViewScale(18+115), label.height+label.y+5, ViewScale(115), 44)];
        [button setTitleColor:ERGBColor(0x737785) forState:UIControlStateNormal];
        [button1 setTitleColor:ERGBColor(0x737785) forState:UIControlStateNormal];
        [button setTitle:@" 下载模板" forState:UIControlStateNormal];
        [button1 setTitle:@" 上传公函" forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button1.layer.borderWidth = 1;
        button.layer.borderColor = ERGBColor(0x737785).CGColor;
        button1.layer.borderColor = ERGBColor(0x737785).CGColor;
        
        [button1 setImage:[UIImage token_image:@"token_arrow_up"] forState:UIControlStateNormal];
        [button setImage:[UIImage token_image:@"token_arrow_down"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
        [pdfView addSubview:button];
        [pdfView addSubview:button1];
    }
    return self;
}
- (TKPhotoPicker *)photoPicker{
    if (_photoPicker == nil) {
        _photoPicker = [TKPhotoPicker photoPicker];
        _photoPicker.allowCrop = false;
        WeakSelf
        [_photoPicker pickingInController:self.viewController handlerBlock:^(NSArray<EPhotoModel *> *photos) {
            weakSelf.letterImage.image = photos.firstObject.image;
            weakSelf.image = photos.firstObject.image;
        }];
    }
    return _photoPicker;
}

- (void)uploadClick{
    WeakSelf
    [self.viewController alertActionSheet:@[@"相册"] handler:^(NSInteger index) {
        [weakSelf.photoPicker openPhotoAlbum];
    }];
}
- (void)downloadClick{
    if (self.letterImage.image != nil) {
        WeakSelf
        [self.viewController e_showHudText:@""];
        [self.letterImage.image save:^(BOOL success) {
            [weakSelf.viewController e_showMessage:success ? @"保存成功":@"保存失败"];
        }];
    }else{
        [self.viewController e_showMessage:@"保存失败"];
    }
}

- (void)updateData:(NSArray *)data{
    self.did = data.firstObject;
    [self requestLetter:data[1] identityCode:data[2] companyName:data[3]];
}

- (void)requestLetter:(NSString *)name identityCode:(NSString *)identityCode companyName:(NSString *)companyName{
    WeakSelf
    [TokenApi letterTemplateWithDid:_did orgName:companyName userIdentityCode:identityCode userName:name handler:^(UIImage *image) {
        weakSelf.letterImage.image = image;
    }];
}

- (CGFloat)e_cellHeight{
    return 1.415*(EWidth-ViewScale(40))+60+44+20;
}

@end



@interface TokenCompanyBusinessLicenseCell()
@property(nonatomic,retain)TKPhotoPicker *photoPicker;
@property(nonatomic,retain)UIButton *button;
@end
@implementation TokenCompanyBusinessLicenseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, EWidth-80, self.e_cellHeight)];
        self.button.adjustsImageWhenHighlighted = false;
        [self.button setBackgroundImage:[UIImage token_image:@"token_license"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(licenseClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return self;
}


- (TKPhotoPicker *)photoPicker{
    if (_photoPicker == nil) {
        _photoPicker = [TKPhotoPicker photoPicker];
        _photoPicker.allowCrop = false;
        WeakSelf
        [_photoPicker pickingInController:self.viewController handlerBlock:^(NSArray<EPhotoModel *> *photos) {
            [weakSelf.button setBackgroundImage:photos.firstObject.image forState:UIControlStateNormal];
            weakSelf.image = photos.firstObject.image;
        }];
        
    }
    return _photoPicker;
}
- (void)licenseClick{
    WeakSelf
    [self.viewController alertActionSheet:@[@"相册"] handler:^(NSInteger index) {
        [weakSelf.photoPicker openPhotoAlbum];
    }];
}
- (CGFloat)e_cellHeight{
    return (EWidth-80)*1.4;
}
@end
