//
//  HHGifImageOperation.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHGifImageOperation : UIView

//通过图片Data数据第一个字节来获取图片扩展名(严谨)
+ (NSString *)hh_contentTypeForImageData:(NSData *)data;

//通过图片URL的截取来获取图片的扩展名(不严谨)
+ (NSString *)hh_contentTypeForImageURL:(NSString *)url;

/**
 *  自定义播放Gif图片
 *
 *  @param frame 位置和大小
 *  @param gifImagePath Gif图片路径
 *
 *  @return Gif图片对象
 */
- (id)initWithFrame:(CGRect)frame gifImagePath:(NSString *)gifImagePath;

/**
 *  自定义播放Gif图片(Data)(本地+网络)
 *
 *  @param frame 位置和大小
 *  @param gifImageData Gif图片Data
 *
 *  @return Gif图片对象
 */
- (id)initWithFrame:(CGRect)frame gifImageData:(NSData *)gifImageData;

/**
 *  自定义播放Gif图片(Name)
 *
 *  @param frame 位置和大小
 *  @param gifImageName Gif图片名称
 *
 *  @return Gif图片对象
 */
- (id)initWithFrame:(CGRect)frame gifImageName:(NSString *)gifImageName;

@end
