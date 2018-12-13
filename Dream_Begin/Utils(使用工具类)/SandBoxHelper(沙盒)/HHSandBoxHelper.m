//
//  HHSandBoxHelper.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHSandBoxHelper.h"

@implementation HHSandBoxHelper

//程序主目录，可见子目录(3个)：Documents、Library、tmp
+ (NSString *)homePath
{
    return NSHomeDirectory();
}

//程序目录，不能存任何东西
+ (NSString *)appPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

//文档目录，需要ITUNES同步备份的数据存在这里，可存放用户数据
+ (NSString *)docPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

//配置目录，配置文件存在这里
+ (NSString *)libPrefPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}

//缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)libCachPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

//临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)tmpPath
{
    return [NSHomeDirectory() stringByAppendingString:@"/tmp"];
}

//用于存储iap内购返回的购买凭证
+ (NSString *)iapReceiptPath
{
    NSString *path = [[self libPrefPath] stringByAppendingFormat:@"/EACEF35EF363A75A"];
    [self hasLive:path];
    return path;
}

+ (BOOL)hasLive:(NSString *)path
{
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return YES;
}

@end
