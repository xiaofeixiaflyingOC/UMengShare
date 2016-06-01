//
//  AppDelegate.h
//  UMengShare
//
//  Created by shengxin on 16/5/31.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate,UIAlertViewDelegate,UIWebViewDelegate,UMSocialUIDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *iNavController;

- (void)showTipView:(UIView *)contentView andText:(NSString*)aTipText;

@end

