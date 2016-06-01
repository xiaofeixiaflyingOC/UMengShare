//
//  AppDelegate.m
//  UMengShare
//
//  Created by shengxin on 16/5/31.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MBProgressHUD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *v = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.iNavController = [[UINavigationController alloc] initWithRootViewController:v];
    //友盟统计
    [self umengTrack];
    //友盟分享
    [self umengShare];
    self.window.rootViewController = self.iNavController;
    [self.window makeKeyAndVisible];
    
    return YES;
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    //  这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
    [UMSocialSnsService  applicationDidBecomeActive];
}

#pragma mark - OpenURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *data = url.absoluteString;
    NSRange range = [data rangeOfString:@"wechat"];
    NSRange range1 = [data rangeOfString:@"source=qq"];
    if (range.location!=NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
    }else if (range1.location!=NSNotFound){
        return [UMSocialSnsService handleOpenURL:url];
    }else{
        return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
}

#pragma mark - UmengMethod
//友盟统计
- (void)umengTrack {
    [MobClick setCrashReportEnabled:NO]; //关闭友盟Crash日志捕获
    //#if DEBUG || ADHOC
    //    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //    [UMCheckUpdate setLogEnabled:YES];
    //    [UMOnlineConfig setLogEnabled:YES];
    //#endif
    [MobClick setAppVersion:XcodeAppVersion];
    [MobClick startWithAppkey:kUMAppKey reportPolicy:(ReportPolicy) REALTIME channelId:SITE_STR];
}

//友盟分享
-(void)umengShare
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:kUMAppKey];
 //   [UMSocialData openLog:YES];
    
    //设置微信AppId
    [UMSocialWechatHandler setWXAppId:kUMWeixinAppID appSecret:kUMWeixinAppSecret url:G_AppStoreURL];//
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:kUMQQAppID appKey:kUMQQAppSecret url:G_AppStoreURL];
    [UMSocialQQHandler setSupportWebView:YES];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:kAppRedirectURL];
    [UMSocialConfig setFinishToastIsHidden:YES  position:UMSocialiToastPositionCenter];
}

#pragma mark- PrivateMethods
-(void) onResp:(BaseResp*)resp{
    //4.4.2
    BOOL isSharedSuccess;
    if(resp.errCode == 0){
        isSharedSuccess = YES;
    }else{
        isSharedSuccess = NO;
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sharedSuccessOrNotNotification"
//                                                        object:@(isSharedSuccess)];
    NSLog(@"%d",resp.errCode);
    if (resp.errCode==0) {
        [self showTipView:self.iNavController.view andText:@"分享成功"];
    }else{
        [self showTipView:self.iNavController.view andText:@"分享失败"];
    }
}

-(void) onReq:(BaseReq*)req{
    NSLog(@"baseReq=%@",req);
}

#pragma mark -MBProgressHUD
- (void)showTipView:(UIView *)contentView andText:(NSString*)aTipText
{
    [self removeHud:contentView];
    MBProgressHUD *aHud = [MBProgressHUD showHUDAddedTo:contentView animated:YES];
    aHud.mode = MBProgressHUDModeText;
    aHud.labelText = aTipText;
    aHud.margin = 10.f;
    aHud.yOffset = 10.f;
    aHud.removeFromSuperViewOnHide = YES;
    [aHud hide:YES afterDelay:1.0];
}

- (void)removeHud:(UIView *)contentView
{
    for (UIView *view in contentView.subviews)
    {
        if ([view isKindOfClass:[MBProgressHUD class]])
        {
            MBProgressHUD *aHud = (MBProgressHUD *)view;
            [aHud hide:YES];
        }
    }
}
@end
