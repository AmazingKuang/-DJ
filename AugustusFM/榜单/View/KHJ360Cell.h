//
//  KHJ360Cell.h
//  AugustusFM
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJ360Model.h"
@interface KHJ360Cell : UITableViewCell
@property (nonatomic, retain) KHJ360Model *model;

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *categoryLabel;
@property (nonatomic, retain) UILabel *duraTionLabel;
@property (nonatomic, retain) UILabel *namelabel;
@property (nonatomic, retain) UILabel *topLabel;
@property (nonatomic, retain) UIImageView *feedImageView;



@end
