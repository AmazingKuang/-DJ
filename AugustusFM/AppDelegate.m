//
//  AppDelegate.m
//  AugustusFM
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AppDelegate.h"
#import "KHJTabBarViewController.h"
#import "KHJNavigationController.h"
#import "JXLDayAndNightMode.h"
#import "KSGuideManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   
    [_window release];

    [self turnToHomePage];
    
    
#pragma mark - 引导页
    NSMutableArray *imagesArray = [NSMutableArray new];
    for (int i = 3; i <= 8; i++) {
        NSString *string = [NSString stringWithFormat:@"%d.JPG",i];
        UIImage *image = [UIImage imageNamed:string];
        [imagesArray addObject:image];
            }
    [[KSGuideManager shared] showGuideViewWithImages:imagesArray];

//    [imagesArray addObject:[UIImage imageNamed:@"000.jpeg"]];
    
    
    return YES;
}
#pragma mark -- APP首页:自定义tabBarController : 自定义navigationController
- (void)turnToHomePage{
    KHJTabBarViewController *tabBarController = [[KHJTabBarViewController alloc] init];
    KHJNavigationController *nav = [[KHJNavigationController alloc] initWithRootViewController:tabBarController];
    self.window.rootViewController = nav;
    
    [tabBarController release];
    [nav release];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
