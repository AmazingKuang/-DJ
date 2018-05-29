//
//  KHJClassificationTableViewCell.m
//  AugustusFM
//
//  Created by dllo on 16/7/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJClassificationTableViewCell.h"
#import "KHJsmallClassCollectionViewCell.h"
#import "JXLDayAndNightMode.h"
@interface KHJClassificationTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *colectionView;

@end


@implementation KHJClassificationTableViewCell
- (void)dealloc{
    [_colectionView release];
    self.colectionView.delegate = nil;
    self.colectionView.dataSource = nil;
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.array = [NSMutableArray array];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(ScreenWidth / 2 - 20 * lFitWidth, 50 * lFitHeight);
        flowLayout.minimumLineSpacing = 5 * lFitHeight;
        flowLayout.minimumInteritemSpacing = 5 * lFitWidth;
        flowLayout.sectionInset = UIEdgeInsetsMake(5 * lFitWidth, 5 * lFitHeight, 5 * lFitWidth, 5 * lFitHeight);
        flowLayout.footerReferenceSize = CGSizeMake(0, 10 * lFitHeight);
        self.colectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 185 * lFitHeight) collectionViewLayout:flowLayout];
        self.colectionView.backgroundColor = [UIColor whiteColor];
        self.colectionView.dataSource = self;
        self.colectionView.delegate  = self;
        self.colectionView.bounces = NO;
        [self.contentView addSubview:_colectionView];
        //注册cell
        [self.colectionView registerClass:[KHJsmallClassCollectionViewCell class] forCellWithReuseIdentifier:@"cCell"];
        //注册尾部视图
        [self.colectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
        
        /**
         夜间模式
         */
        [self jxl_setDayMode:^(UIView *view) {
            
            // 设置日间模式状态
            view.backgroundColor = [UIColor whiteColor]; // view为当前设置的视图
            _colectionView.backgroundColor = [UIColor whiteColor];

            
        } nightMode:^(UIView *view) {
            
            // 设置夜间模式状态
            view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00]; // view为当前设置的视图
            
            _colectionView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];                
        }];

    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJsmallClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cCell" forIndexPath:indexPath];
    if (self.array.count != 0) {
    cell.model = [self.array objectAtIndex:indexPath.item + _number * 6];
    }
       return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KHJNovelDetailViewController *kvc = [[KHJNovelDetailViewController alloc] init];
    if (self.array.count != 0) {
       kvc.model = [self.array objectAtIndex:indexPath.item + _number * 6];
//        NSLog(@"分类里###%ld",[kvc.model.idd integerValue]);
    }
   
    self.block(kvc);
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
        return headerView;
}
- (void)setArray:(NSMutableArray *)array{
    if (_array != array) {
        [_array release];
        _array = [array retain];
    }
    [self.colectionView reloadData];
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
