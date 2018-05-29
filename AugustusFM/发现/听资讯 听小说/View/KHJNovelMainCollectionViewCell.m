//
//  KHJNovelMainCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJNovelMainCollectionViewCell.h"
#import "KHJDeTailRecommendTableViewCell.h"
#import <MJRefresh.h>
#import "JXLDayAndNightMode.h"
@interface KHJNovelMainCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger pageNumber;
@end


@implementation KHJNovelMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageNumber = 1;
        self.listArray = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50) style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self.delegate getdelegateData:_pageNumber];
//
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            _pageNumber++;
            [self.delegate getdelegateData:_pageNumber];
        }];
        
        [self.contentView addSubview:_tableView];
        //注册cell
        [self.tableView registerClass:[KHJDeTailRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        /**
         *  夜间模式
         */
        [_tableView jxl_setDayMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            
            view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
            
        }];

        
        
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDeTailRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [self.listArray objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJspecialDetailViewController *khvc = [[KHJspecialDetailViewController alloc] init];
    khvc.model = [self.listArray objectAtIndex:indexPath.row];
    self.block(khvc);
    
}


- (void)setListArray:(NSMutableArray *)listArray{
    if (_listArray != listArray) {
        [_listArray release];
        _listArray = [listArray retain];
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}



@end
