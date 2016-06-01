//
//  ShareModelHelper.h
//  UMengShare
//
//  Created by shengxin on 16/6/1.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kSharePlatformType) {
    kSharePlatformWXSceneSession = 0,
    kSharePlatformWXSceneTimeline,
    kSharePlatformQQZone,
    kSharePlatformQQFriends,
    kSharePlatformSinaWeibo,
    kSharePlatformEmail,
    kShareCopyLink,
    kShareOpenUrlWithSafari,
    kShareRefresh
};

@interface ShareModelHelper : NSObject

+(ShareModelHelper*)sharedInstance;
/**
 *  返回分享标示
 *  @param isCome 是否进行浏览器预览 多用于H5活动页
 */
-(NSArray*)getSharePlatformTypeAndIsComeInternal:(BOOL)isCome;

@end
