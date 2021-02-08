//
//  AppDelegate.m
//  RotaryTableDemo
//
//  Created by zhaixingxing on 2021/2/2.
//

#import "AppDelegate.h"
#import "IQKeyboardManager/IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 键盘的设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    //当键盘弹起时，点击背景收起键盘
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;
    //设置右侧按钮颜色,内容和大小
    manager.toolbarDoneBarButtonItemText = @"完成";
    manager.placeholderFont = [UIFont systemFontOfSize:15];
    
    
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
