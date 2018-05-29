//
//  KHJDeTailRecommendTableViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJDetailRecommend.h"
@interface KHJDeTailRecommendTableViewCell : UITableViewCell

@property (nonatomic, retain) KHJDetailRecommend *model;
- (CGFloat)cellOffset;
@end
