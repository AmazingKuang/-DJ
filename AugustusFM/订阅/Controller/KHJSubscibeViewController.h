//
//  KHJSubscibeViewController.h
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@interface KHJSubscibeViewController : WMPageController

/**
 *  单例一个带有WMPageController的订阅页面
 */

+ (UINavigationController *)defaultSubscibeViewUINavigationController;

@end
