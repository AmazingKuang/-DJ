//
//  KHJFindTopSearchView.h
//  AugustusFM
//
//  Created by dllo on 16/7/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBaseView.h"

typedef void(^TurnToSearchPage)(void);

@interface KHJFindTopSearchView : KHJBaseView

@property (nonatomic, retain) UILabel *logoLabel;
@property (nonatomic, retain) UIButton *searchButton;
//跳转到搜索页面
@property (nonatomic, copy) TurnToSearchPage turnToSearchPageBlock;

@end
