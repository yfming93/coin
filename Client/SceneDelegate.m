//
//  SceneDelegate.m
//  Client
//
//  Created by mingo on 2021/1/5.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "FMTabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    [self initWithWindowScene:(UIWindowScene *)scene];
    [self FMNetworkingManagerConfig];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}


    /// 初始化 UIWindow
- (void)initWithWindowScene:(UIWindowScene *)scene {
        //1.创建窗口
    self.window = [UIWindow.alloc initWithWindowScene:scene];
    
        //3.把控制器设置为窗口的根控制器
    self.window.rootViewController = FMTabBarController.new;
    
        //4.设置窗口为app的主窗口并且可见
    [self.window makeKeyAndVisible];
}


#pragma mark - FMNetworkingManager
- (void)FMNetworkingManagerConfig {
    FMNetworkingManager.sharedInstance.token = kUserInfo.authorization;
    FMNetworkingManager.sharedInstance.mainHostUrl = FMAssistiveTouchManager.shareInstance.kMainHost;
    FMAssistiveTouchManager.shareInstance.hostChangeBlock = ^(id objc) {
        FMNetworkingManager.sharedInstance.mainHostUrl = objc;
    };
    FMNetworkingManager.sharedInstance.codeLogout = 100;
    FMNetworkingManager.sharedInstance.codeSuccess = 111111;
    FMNetworkingManager.sharedInstance.codetokenError = 201;
    FMNetworkingManager.sharedInstance.timeout = 15;
    FMNetworkingManager.sharedInstance.messagekey = @"msg";
    FMNetworkingManager.sharedInstance.tokenKeyName = @"Authorization";
    FMNetworkingManager.sharedInstance.loginClassString = @"FMLoginViewController";
    if (kUserInfo.authorization.length) {
        [FMNetworkingManager.sharedInstance.dicDefaultHeader setObject:kUserInfo.authorization forKey:@"Authorization"];
        
    }
    
}

@end
