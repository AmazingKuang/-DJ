//
//  KHJProvinceBroadcastCollectionViewCell.h
//  AugustusFM
//
//  Created by dllo on 16/7/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KHJProvinceBroadcastCollectionViewCellDelegate <NSObject>

- (void)getDelegateData:(NSInteger)pageNumber;
@end



@interface KHJProvinceBroadcastCollectionViewCell : UICollectionViewCell
/**<#注释#>*/
@property (nonatomic, retain)NSMutableArray *array;

@property (nonatomic, assign) id<KHJProvinceBroadcastCollectionViewCellDelegate>delegate;



@end

