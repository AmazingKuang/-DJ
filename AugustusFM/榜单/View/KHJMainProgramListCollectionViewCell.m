//
//  KHJMainProgramListCollectionViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJMainProgramListCollectionViewCell.h"
#import "KHJTwoProgramListCell.h"
#import "KHJThreeProgramCell.h"


@interface KHJMainProgramListCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@end
@implementation KHJMainProgramListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.contentView addSubview:_tableView];
        
        //注册cell
        [self.tableView registerClass:[KHJTwoProgramListCell class] forCellReuseIdentifier:@"twoCell"];
        
        //注册cell
        [self.tableView registerClass:[KHJThreeProgramCell class] forCellReuseIdentifier:@"cell"];
        
        
        
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90 * lFitHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_titleString isEqualToString:@"track"]){
        return _firstArray.count;
    }
    return _firstArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_titleString isEqualToString:@"track"]) {
        KHJTwoProgramListCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        twoCell.model = [self.firstArray objectAtIndex:indexPath.row];
        twoCell.labelInter = indexPath.item + 1;
        return twoCell;
    }
    KHJThreeProgramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = [self.firstArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelInter = indexPath.item + 1;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_titleString isEqualToString:@"track"]) {
        KHJPlayerMusiciViewController *vc = [KHJPlayerMusiciViewController shareDetailViewController];
        vc.model = [self.firstArray objectAtIndex:indexPath.item];
        vc.musicArr = self.firstArray;
        vc.index = indexPath.row;
        self.blk(vc);
    }
    else{
        KHJspecialDetailViewController *kpvc = [[KHJspecialDetailViewController alloc] init];
        kpvc.model = [self.firstArray objectAtIndex:indexPath.row];
        self.block(kpvc);
        
    }
    
    //通知按钮旋转,播放及按钮改变图片和状态
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"coverURL"] = [NSURL URLWithString:[[self.firstArray objectAtIndex:indexPath.row] coverSmall]];
    
    //        userInfo[@"musicURL"] = [NSURL URLWithString:[[self.programArray objectAtIndex:indexPath.row] playUrl64]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginPlay" object:nil userInfo:[userInfo copy]];
    
    
}


- (void)setFirstArray:(NSMutableArray *)firstArray{
    if (_firstArray != firstArray) {
        [_firstArray release];
        _firstArray = [firstArray retain];
    }
    [self.tableView reloadData];
}
@end
