//
//  HHMineLogic.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/21.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HHMineLogicDelegate <NSObject>

@optional
//数据加载完成
- (void)requestDataCompleted;

@end

@interface HHMineLogic : NSObject

//数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

//代理
@property (nonatomic, weak) id<HHMineLogicDelegate>myDelegate;

//获取数据
- (void)loadData;

@end
