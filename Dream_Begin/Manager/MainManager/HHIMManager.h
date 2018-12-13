//
//  HHIMManager.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^loginBlock)(BOOL success, NSString *desc);

/**
 IM服务与管理
 */

@interface HHIMManager : NSObject

SINGLETON_FOR_HEADER(HHIMManager)

//初始化IM
- (void)initIM;

/**
 *  登录IM
 *
 *  @param IMID       IM账号
 *  @param IMPwd      IM密码
 *  @param completion block回调
 */
- (void)IMLogin:(NSString *)IMID IMPwd:(NSString *)IMPwd completion:(loginBlock)completion;

//退出IM
- (void)IMLogout;

@end
