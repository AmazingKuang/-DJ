//
//  KHJProvinceBroadcastCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJProvinceBroadcastCollectionViewCell.h"
#import "KHJDalianTableViewCell.h"
#import <MJRefresh.h>
@interface KHJProvinceBroadcastCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) NSInteger pNumber;
@property (nonatomic, assign) NSInteger selectItem;
@end

@implementation KHJProvinceBroadcastCollectionViewCell
- (void)dealloc{
    [_tableView release];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pNumber = 1;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_tableView];
        [_tableView release];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.delegate getDelegateData:1];
        }];
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pNumber++;
            [self.delegate getDelegateData:_pNumber];
          
        }];
        
        
        //注册cell
        [self.tableView registerClass:[KHJDalianTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95 * lFitHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KHJDalianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.array.count) {
        cell.model = [self.array objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //显示当前播放行:
    if (_selectItem != indexPath.row) {
        [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectItem inSection:0]] soundImageView] setImage:[UIImage imageNamed:@"sound_playbtn"]];
    }
    [[(KHJDalianTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] soundImageView] setImage:[UIImage imageNamed:@"cell_sound_pause_n"]];
    
    //通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[self.array objectAtIndex:indexPath.row] coverSmall]];
    userInfo[@"musicURL"] = [NSURL URLWithString:[[self.array objectAtIndex:indexPath.row] ts24]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    NSString *state = @"";
    if (_selectItem == indexPath.item) {
        state = @"play";
    } else {
        state = @"pause";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"good" object:state];
    _selectItem = indexPath.row;

}


- (void)setArray:(NSMutableArray *)array{
    if (_array != array) {
        [_array release];
        _array = [array retain];
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
@end
