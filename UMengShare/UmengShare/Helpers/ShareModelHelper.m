//
//  ShareModelHelper.m
//  UMengShare
//
//  Created by shengxin on 16/6/1.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "ShareModelHelper.h"

@interface ShareModelHelper()

@end

@implementation ShareModelHelper

#pragma mark - public
+(ShareModelHelper*)sharedInstance{
    static ShareModelHelper *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ShareModelHelper alloc] init];
    });
    return obj;
}

-(NSArray*)getSharePlatformTypeAndIsComeInternal:(BOOL)isCome{
   NSArray *sharePlatformTypeArr;
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        if (![WXApi isWXAppInstalled]) {
            NSLog(@"没qq 和 没微信");
            if (isCome==YES) {
                //@"新浪微博",@"电子邮件",@"复制链接",@"在Safari中打开",@"刷新页面"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],[NSNumber numberWithInt:kShareOpenUrlWithSafari],[NSNumber numberWithInt:kShareRefresh],nil];
            }else{
                //@"新浪微博",@"电子邮件",@"复制链接"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],nil];
            }
        }else{
            NSLog(@"没qq 和 有微信");
            if (isCome==YES) {
                //@"微信好友",@"微信朋友圈",@"新浪微博",@"腾讯微博",@"电子邮件",@"复制链接",@"在Safari中打开",@"刷新页面"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformWXSceneSession],[NSNumber numberWithInt:kSharePlatformWXSceneTimeline],[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],[NSNumber numberWithInt:kShareOpenUrlWithSafari],[NSNumber numberWithInt:kShareRefresh],nil];
            }else{
                //@"微信好友",@"微信朋友圈",@"新浪微博",@"腾讯微博",@"电子邮件",@"复制链接"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformWXSceneSession],[NSNumber numberWithInt:kSharePlatformWXSceneTimeline],[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],nil];
            }
        }
    }else{
        if (![WXApi isWXAppInstalled]) {
            NSLog(@"有qq 和 没微信");
            if (isCome==YES) {
                //@"QQ空间",@"QQ好友",@"新浪微博",@"腾讯微博",@"电子邮件",@"复制链接",@"在Safari中打开",@"刷新页面"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformQQZone],[NSNumber numberWithInt:kSharePlatformQQFriends],[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],[NSNumber numberWithInt:kShareOpenUrlWithSafari],[NSNumber numberWithInt:kShareRefresh],nil];
            }else{
                //@"QQ空间",@"QQ好友",@"新浪微博",@"腾讯微博",@"电子邮件",@"复制链接"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformQQZone],[NSNumber numberWithInt:kSharePlatformQQFriends],[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],nil];
            }


            
        }else{
            NSLog(@"有qq 和 有微信");
            if (isCome==YES) {
                //@"微信好友",@"微信朋友圈",@"QQ空间",@"QQ好友",@"新浪微博",@"腾讯微博",@"电子邮件",@"复制链接",@"在Safari中打开",@"刷新页面"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformWXSceneSession],[NSNumber numberWithInt:kSharePlatformWXSceneTimeline],[NSNumber numberWithInt:kSharePlatformQQZone],[NSNumber numberWithInt:kSharePlatformQQFriends],[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],[NSNumber numberWithInt:kShareOpenUrlWithSafari],[NSNumber numberWithInt:kShareRefresh],nil];
            }else{
                //@"微信好友",@"微信朋友圈",@"QQ空间",@"QQ好友",@"新浪微博",@"腾讯微博",@"电子邮件",@"复制链接",@"在Safari中打开",@"刷新页面"
                sharePlatformTypeArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:kSharePlatformWXSceneSession],[NSNumber numberWithInt:kSharePlatformWXSceneTimeline],[NSNumber numberWithInt:kSharePlatformQQZone],[NSNumber numberWithInt:kSharePlatformQQFriends],[NSNumber numberWithInt:kSharePlatformSinaWeibo],[NSNumber numberWithInt:kSharePlatformEmail],[NSNumber numberWithInt:kShareCopyLink],nil];
            }
        }
    }
    return sharePlatformTypeArr;
}




@end
