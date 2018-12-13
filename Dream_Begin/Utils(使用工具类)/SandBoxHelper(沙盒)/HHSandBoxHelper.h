//
//  HHSandBoxHelper.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHSandBoxHelper : NSObject

//程序主目录，可见子目录(3个)：Documents、Library、tmp
+ (NSString *)homePath;
//程序目录，不能存任何东西
+ (NSString *)appPath;
//文档目录，需要ITUNES同步备份的数据存在这里，可存放用户数据
+ (NSString *)docPath;
//配置目录，配置文件存在这里
+ (NSString *)libPrefPath;
//缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)libCachPath;
//临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)tmpPath;
//用于存储iap内购返回的购买凭证
+ (NSString *)iapReceiptPath;

@end
