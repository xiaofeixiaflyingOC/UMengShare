//
//  ShareActionManager.h
//  UMengShare
//
//  Created by shengxin on 16/6/1.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareActionManager : NSObject

+ (instancetype)shareInstance;
- (void)shareToPlatformType:(kSharePlatformType)shareType
         FromViewController:(UIViewController*)vc
          andPostShareModel:(ShareActionModel*)shareModel;
@end
