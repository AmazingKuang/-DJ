//
//  GetHeightTools.m
//  UI12_自适应Cell高度
//
//  Created by Rain on 16/6/22.
//  Copyright © 2016年 Rain. All rights reserved.
//

#import "GetHeightTools.h"

@implementation GetHeightTools

+ (CGFloat)heightWith:(NSString *)text {
    
    NSDictionary *attributesDic = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:17]
                                    };
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    
    
    /** 返回计算出来的高度. */
    return rect.size.height;
    
}
+ (CGFloat)getTextWidth:(NSString *)text withFontSize:(NSInteger)size{
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:size]
                          };
    CGRect rect = [text boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic                                  context:nil];
    return rect.size.width;
    
}
+ (CGFloat)imageHeightWith:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    /** 根据图片的宽高比例算出自适应高度. */
    CGFloat height =  image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
    
    return height;
}














@end
