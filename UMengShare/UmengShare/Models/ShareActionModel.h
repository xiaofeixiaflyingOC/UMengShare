//
//  ShareActionModel.h
//  UMengShare
//
//  Created by shengxin on 16/5/31.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareActionModel : NSObject

@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *commentStr;
@property(nonatomic,copy)NSString *shareUrl;
@property(nonatomic,copy)NSString *wxImageUrl;//微信分享图片
@property(nonatomic,copy)NSString *shareImageUrl;//其他分享图片

@end
