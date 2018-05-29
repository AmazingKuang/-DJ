//
//  KHJBigPayTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJBigPayTableViewCell.h"
#import "KHJPayCollectionViewCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJBigPayTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *dataSource;

@end
@implementation KHJBigPayTableViewCell

- (void)dealloc{
    [_collectionView release];
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    [_dataSource release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataSource = [NSMutableArray array];
        //        [self getData];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(120 * lFitWidth, 180 * lFitHeight);
        
        flowLayout.minimumLineSpacing = 5 * lFitHeight;
        flowLayout.minimumInteritemSpacing = 5 * lFitWidth;
        flowLayout.sectionInset = UIEdgeInsetsMake(5 * lFitWidth, 5 * lFitHeight, 5 * lFitWidth, 15 * lFitHeight);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200 * lFitHeight) collectionViewLayout:flowLayout];
//        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.contentView addSubview:_collectionView];
        //注册付费精品,听资讯..CollectionViewcell
        [self.collectionView registerClass:[KHJPayCollectionViewCell class] forCellWithReuseIdentifier:@"cCell"];
        
        [self jxl_setDayMode:^(UIView *view) {
            
            // 设置日间模式状态
            self.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
            _collectionView.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            
            // 设置夜间模式状态
            self.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
            _collectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        }];

        
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJPayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cCell" forIndexPath:indexPath];
    cell.model = [self.dataSource objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJspecialDetailViewController *kpvc = [[KHJspecialDetailViewController alloc] init];
    kpvc.model = [self.dataSource objectAtIndex:indexPath.row];
    self.block(kpvc);
}


- (void)setModel:(KHJBigPayModel *)model{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.dataSource = model.listArray;
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
