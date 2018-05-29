//
//  KHJAnchorTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJAnchorTableViewCell.h"
#import "KHJsmallAnchorCollectionViewCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJAnchorTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@end


@implementation KHJAnchorTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataArray = [NSMutableArray array];
        UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
        flowOut.itemSize = CGSizeMake(ScreenWidth / 3 - 10 * lFitWidth, 170 * lFitHeight);
        flowOut.minimumLineSpacing = 5 * lFitHeight;
        flowOut.minimumInteritemSpacing = 5 * lFitWidth;
        flowOut.sectionInset = UIEdgeInsetsMake(5 * lFitHeight, 5 * lFitWidth, 5 * lFitHeight, 5 * lFitWidth);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180 * lFitHeight) collectionViewLayout:flowOut];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.bounces = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];
        
        
        //注册cell
        [self.collectionView registerClass:[KHJsmallAnchorCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        /**
         夜间模式
         */
        [self jxl_setDayMode:^(UIView *view) {
            
            // 设置日间模式状态
            view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
            _collectionView.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            
            // 设置夜间模式状态
            view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
           
            _collectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
          }];

    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJsmallAnchorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = [self.model.listArray objectAtIndex:indexPath.item];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJSecondAnchorDetailViewController *lsvc = [[KHJSecondAnchorDetailViewController alloc] init];
    lsvc.model = [self.model.listArray objectAtIndex:indexPath.row];
//    NSLog(@"%@",lsvc.model.nickname);
    self.block(lsvc);
}

- (void)setModel:(KHJAnchorModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    [self.collectionView reloadData];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
