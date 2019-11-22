//
//  TokenCompanyCell.h
//  TokenSDK
//
//  Created by easy on 2019/10/28.
//  Copyright © 2019 easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface TokenCompanyCell : UITableViewCell

@end


@interface TokenCompanyCertificationTitleCell : UITableViewCell<EListViewProtocol>

@end



@interface TokenCompanyLetterCell : UITableViewCell<EListViewProtocol>
@property(nonatomic,retain)UIImage *image;
@end

@interface TokenCompanyBusinessLicenseCell : UITableViewCell<EListViewProtocol>

@property(nonatomic,retain)UIImage *image;

@end








NS_ASSUME_NONNULL_END
