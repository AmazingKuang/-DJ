//
//  KHJSoundTopView.h
//  AugustusFM
//
//  Created by dllo on 16/7/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHJParticularsModel.h"

typedef void(^GoBackPageBlock)(void);
@interface KHJSoundTopView : UIView
/** 模态返回block */
@property(nonatomic, copy) GoBackPageBlock goBackBlock;
/** 数据源模型 */
@property(nonatomic, retain) KHJParticularsModel *model;
@end
