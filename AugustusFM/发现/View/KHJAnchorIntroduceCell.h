//
//  KHJAnchorIntroduceCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJAnchorIntroduceModel.h"
@interface KHJAnchorIntroduceCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *smallLogoImageView;

@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *followersLabel;
@property (nonatomic, retain) UILabel *personalSignatureLabel;


@property (nonatomic, retain) KHJAnchorIntroduceModel *model;
@end
