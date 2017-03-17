//
//  AppDelegate.m
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGAppDelegate.h"
#import "KGHomeViewController.h"
#import "KGHomeNavController.h"
#import "KGRootViewController.h"

/*
 *    * 导航条左侧的酷狗图标颜色不对
 */

@interface KGAppDelegate ()

@end

@implementation KGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self configure];
    
    _window.rootViewController = [[KGRootViewController alloc] init];
    _window.backgroundColor = KGRGBWhite;
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)configure {
    [self setNavBarStyle];
}

/// 统一设置导航栏外观,这个在配置中决定更好,下次修改
- (void)setNavBarStyle {
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSBundle *b = [KGConfig sharedConfig].curThemeBundle;
    
    /** 设置导航栏背景图片 */
    if (b) {
        
        NSString *navBgImgName = [b pathForImageResourceWithName:@"home_top_bg"];
        
        UIImage *navBgImg = [UIImage imageWithContentsOfFile:navBgImgName];
        
        // 确定拉伸的范围,中间0.6部分的拉伸,目前看上去还比较正常
        CGFloat top = navBgImg.size.height * 0.5;
        CGFloat bottom = navBgImg.size.height * 0.5;
        CGFloat left = navBgImg.size.width * 0.2;
        CGFloat right = navBgImg.size.width * 0.2;
        
        // 设置端盖的值
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 设置拉伸的模式
        UIImageResizingMode mode = UIImageResizingModeStretch;
        
        // 拉伸图片
        UIImage *newImage = [navBgImg resizableImageWithCapInsets:edgeInsets resizingMode:mode];

        [navBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
    }
    
    /** 设置导航栏标题文字颜色 */
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : KGHexRGB(0xffffff)
                           };
    [navBar setTitleTextAttributes:dict];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
