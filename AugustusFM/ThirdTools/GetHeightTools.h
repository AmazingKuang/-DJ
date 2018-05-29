//
//  GetHeightTools.h
//  UI12_自适应Cell高度
//
//  Created by Rain on 16/6/22.
//  Copyright © 2016年 Rain. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@interface GetHeightTools : NSObject

+ (CGFloat)heightWith:(NSString *)text;
+ (CGFloat)getTextWidth:(NSString *)text withFontSize:(NSInteger)size;
+ (CGFloat)imageHeightWith:(NSString *)imageName;
















@end
