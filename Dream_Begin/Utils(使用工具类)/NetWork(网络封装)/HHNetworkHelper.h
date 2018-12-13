//
//  HHNetworkHelper.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/19.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HHNetworkCache.h"

typedef NS_ENUM(NSUInteger, HHNetworkStatusType) {
    //位置网络
    HHNetworkStatusUnknow,
    //无网络
    HHNetworkStatusNotReachable,
    //手机网络
    HHNetworkStatusReachableViaWWAN,
    //WIFI网络
    HHNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, HHRequestSerializer) {
    //设置请求数据为JSON格式
    HHRequestSerializerJSON,
    //设置请求数据为二进制格式
    HHRequestSerializerHTTP
};

typedef NS_ENUM(NSUInteger, HHResponseSerializer) {
    //设置响应数据为JSON格式
    HHResponseSerializerJSON,
    //设置响应数据为二进制格式
    HHResponseSerializerHTTP
};

/**
    通用的callBack
 
    @param success 接口是否请求成功
    @param responseObject 返回数据
    @param error 错误信息
 */
typedef void(^HttpRequestCallBack)(BOOL success, id responseObject, NSError * error);

//请求成功的block
typedef void(^HHHttpRequestSuccess)(id responseObject);

//请求失败的block
typedef void(^HHHttpRequestFailed)(NSError *error);

//缓存的block
typedef void(^HHHttpRequestCache)(id responseCache);

//上传或者下载速度，Progress.completedUnitCount:当前大小、Progress.totalUnitCount:总大小
typedef void(^HHHttpProgress)(NSProgress *progress);

//网络状态的block
typedef void(^HHNetworkStatus)(HHNetworkStatusType status);

@class AFHTTPSessionManager;

@interface HHNetworkHelper : NSObject

//有网YES, 无网:NO
+ (BOOL)isNetwork;

//手机网络：YES，反之：NO
+ (BOOL)isWWANNetwork;

//WiFi网络：YES，反之：NO
+ (BOOL)isWiFiNetwork;

//取消所有HTTP请求
+ (void)cancelAllRequest;

//实时获取网络状态，通过block回调实时获取（此方法可多次调用）
+ (void)netWorkStatusWithBlock:(HHNetworkStatus)networkStatus;

//取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL;

//开启日志打印（debug级别）
+ (void)openLog;

//关闭日志打印，默认关闭
+ (void)closeLog;

//开启加密
+ (void)openAES;

//关闭加密，关闭后要记得开启，不然影响其他接口
+ (void)closeAES;

/**
 *  GET请求，无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求，调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(HHHttpRequestSuccess)success
                           failure:(HHHttpRequestFailed)failure;

/**
 *  GET请求，自动缓存
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求，调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                     responseCache:(HHHttpRequestCache)responseCache
                           success:(HHHttpRequestSuccess)success
                           failure:(HHHttpRequestFailed)failure;

/**
 *  POST请求，无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求，调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                            success:(HHHttpRequestSuccess)success
                            failure:(HHHttpRequestFailed)failure;

/**
 *  POST请求，自动缓存
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求，调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                        parameters:(id)parameters
                     responseCache:(HHHttpRequestCache)responseCache
                           success:(HHHttpRequestSuccess)success
                           failure:(HHHttpRequestFailed)failure;

/**
 *  上传文件
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param name         文件对应服务器上的字段
 *  @param filePath     文件本地的沙盒路径
 *  @param progress     上传进度信息
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求，调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                        filePath:(NSString *)filePath
                                        progress:(HHHttpProgress)progress
                                         success:(HHHttpRequestSuccess)success
                                         failure:(HHHttpRequestFailed)failure;

/**
 *  上传文单/多张图片
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param name         图片对应服务器上的字段
 *  @param images       图片数组
 *  @param fileNames    图片文件名数组，可以为nil，数组内的文件名默认为当前日期时间"yyyyMMddhhmmss"
 *  @param imageScale   图片文件压缩比 范围（0.f ~ 1.f）
 *  @param imageType    图片文件类型，例:png、jpg(默认类型)...
 *  @param progress     上传进度信息
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求，调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                        parameters:(id)parameters
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(HHHttpProgress)progress
                                           success:(HHHttpRequestSuccess)success
                                           failure:(HHHttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(HHHttpProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(HHHttpRequestFailed)failure;

#pragma mark -- 设置AFHTTPSessionManager相关属性 --
#pragma mark -- 注意:因为全局只有一个AFHTTPSessionManager实例,所以一下设置方式全局生效 --
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer HHRequestSerializerJSON(JSON格式),HHRequestSerializerHTTP(二进制格式)
 */
+ (void)setRequestSerializer:(HHRequestSerializer)requestSerializer;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param responseSerializer HHResponseSerializerJSON(JSON格式),HHResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(HHResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30s
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

//设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetWorkActivityIndicator:(BOOL)open;

/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
     一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;

@end
