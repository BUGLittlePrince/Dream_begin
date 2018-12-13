//
//  HHHomePageLogic.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/3.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HHHomePageLogicDelegate <NSObject>

@optional
//数据加载完成
- (void)requestDataCompleted;

@end

@interface HHHomePageLogic : NSObject

//数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
//页码
@property (nonatomic, assign) NSInteger page;

//代理
@property (nonatomic, weak) id<HHHomePageLogicDelegate>myDelegate;

//获取数据
- (void)loadData;

@end
