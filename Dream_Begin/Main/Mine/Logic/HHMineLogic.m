//
//  HHMineLogic.m
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/21.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHMineLogic.h"
#import "HHMineCellModel.h"

@interface HHMineLogic()

@property (nonatomic, strong) NSDictionary *rootDict;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation HHMineLogic

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"mineList" ofType:@"plist"];
        _rootDict = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    }
    return self;
}

#pragma mark -- 获取数据 --
- (void)loadData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSArray *array in _rootDict) {
            [_dataArray addObject:array];
        }
    });
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(requestDataCompleted)]) {
        [self.myDelegate requestDataCompleted];
    }
}

@end
