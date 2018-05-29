//
//  KHJSearchContentTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJDetailRecommend.h"
@interface KHJSearchContentTableViewCell : UITableViewCell
@property(nonatomic, retain)UIImageView *leftImageView;
@property(nonatomic, retain)UILabel *titleLbel;
@property(nonatomic, retain)UILabel *categoryLabel;
@property(nonatomic, retain)KHJDetailRecommend *model;

@property(nonatomic, copy)NSString *searchText;
@end
