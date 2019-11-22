//
//  TKIdentityImagesCell.m
//  TokenSDK
//
//  Created by easy on 2019/10/24.
//  Copyright © 2019 easy. All rights reserved.
//

#import "TKIdentityImagesCell.h"
#import "TKHeader.h"

@interface TKIdentityControl : UIControl
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UIImage *image;
@end



@interface TKIdentityImagesCell()<EListViewProtocol>

@property(nonatomic,retain)NSMutableArray<TKIdentityControl *> *buttons;
@property(nonatomic,retain)TKPhotoPicker *photoPicker;

@end

@implementation TKIdentityImagesCell

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

- (NSArray *)identityImages{
    UIImage *img1 = self.buttons[0].image;
    UIImage *img2 = self.buttons[1].image;
    UIImage *img3 = self.buttons[2].image;
    if (img1 && img2 && img3) {
        return @[img1,img2,img3];
    }
    return nil;
}


- (TKPhotoPicker *)photoPicker{
    if (_photoPicker == nil) {
        _photoPicker = [TKPhotoPicker photoPicker];
    }
    return _photoPicker;
}

- (void)imageClick:(TKIdentityControl *)bt{
    [self.viewController.view endEditing:true];
    WeakSelf
    
    CGFloat dw = EWidth - 10;
    CGFloat dh = 0.63 * dw;
    self.photoPicker.allowCrop = (bt.tag != 2);
    
    self.photoPicker.cropRect = CGRectMake(5, (EHeight-dh)*0.5, dw, dh);
    [self.photoPicker pickingInController:self.viewController handlerBlock:^(NSArray<EPhotoModel *> * _Nonnull photos) {
        weakSelf.buttons[bt.tag].imageView.image = photos.firstObject.image;
        weakSelf.buttons[bt.tag].image = photos.firstObject.image;
    }];
    [self.viewController alertActionSheet:@[@"相机",@"相册"] handler:^(NSInteger index) {
        if (index == 0) {
            [weakSelf.photoPicker openCamera];
        }else{
            [weakSelf.photoPicker openPhotoAlbum];
        }
    }];
}

- (void)initView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 50)];
    label.text = @"上传证件照片";
    label.font = TKSDKFont(15);
    label.textColor = ERGBColor(0x374F66);
    [self.contentView addSubview:label];
    
    self.buttons = [NSMutableArray array];
    
    for (int i = 0; i < 3; ++i) {
        TKIdentityControl *bt = [[TKIdentityControl alloc] initWithFrame:CGRectMake((EWidth-ViewScale(236))*0.5, 50+i*ViewScale(160), ViewScale(236), ViewScale(140))];
        UIImage *image = [UIImage token_image:[NSString stringWithFormat:@"token_identity_image%d",i+1]];
        bt.imageView.image = image;
        bt.tag = i;
        [bt addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bt];
        [self.buttons addObject:bt];
    }
}

- (CGFloat)e_cellHeight{
    return 50+3*ViewScale(160);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end




@implementation TKIdentityControl


- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = true;
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end
