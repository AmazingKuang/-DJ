//
//  KHJNovelRecommendCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNovelRecommendCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "KHJDeTailRecommendTableViewCell.h"
#import "KHJNovelBigModel.h"

@interface KHJNovelRecommendCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) SDCycleScrollView *sdScrollView;

@end

@implementation KHJNovelRecommendCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        view.backgroundColor = [UIColor redColor];
        self.tableView.tableHeaderView = view;
        
        self.sdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:view.frame delegate:self placeholderImage:[UIImage imageNamed:@"1F63787E7F1949EDEB659FF4ACE4DB04"]];
        
        [view addSubview:_sdScrollView];
        
        [self addSubview:_tableView];
        //注册cell
        [self.tableView registerClass:[KHJDeTailRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mainArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    KHJNovelBigModel *bigModel =self.mainArray[section];
       return bigModel.listArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDeTailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     KHJNovelBigModel *bigModel = self.mainArray[indexPath.section];
  
    cell.model = [bigModel.listArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 13, 12)];
    imageView.image = [UIImage imageNamed:@"liveRadioCellPoint"];
    [headerView addSubview:imageView];
    KHJNovelBigModel *model = [self.mainArray objectAtIndex:section];
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = model.title;
    [headerView addSubview:label];
//    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 1.2176 , 0, ScreenWidth * 0.1, ScreenHeight * 0.05)];
//    rightLabel.font = [UIFont systemFontOfSize:14];
//    rightLabel.text = @"更多";
//    rightLabel.alpha = 0.5;
//    [headerView addSubview:rightLabel];
//    
//    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(385, 5, 10, 10)];
//    rightImageView.image = [UIImage imageNamed:@"np_loverview_arraw"];
//    [headerView addSubview:rightImageView];
    
    
    
    
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJspecialDetailViewController *khjvc = [[KHJspecialDetailViewController alloc] init];
    KHJNovelBigModel *bigModel = self.mainArray[indexPath.section];
    khjvc.model = [bigModel.listArray objectAtIndex:indexPath.row];
    self.block(khjvc);
    
}

- (void)setTopscrollviewArray:(NSMutableArray *)topscrollviewArray{
    if (_topscrollviewArray != topscrollviewArray) {
        [_topscrollviewArray release];
        _topscrollviewArray = [topscrollviewArray retain];
    }
    
    self.sdScrollView.imageURLStringsGroup = topscrollviewArray;
   
}

- (void)setMainArray:(NSMutableArray *)mainArray{
    if (_mainArray != mainArray) {
        [_mainArray release];
        _mainArray = [mainArray retain];
    }
    
     [self.tableView reloadData];
}
@end
