//
//  HHHomePageLogic.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/3.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHHomePageLogic.h"
#import "HHHomePageCellModel.h"

@interface HHHomePageLogic ()

@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation HHHomePageLogic

- (instancetype)init
{
    if (self = [super init]) {
        _dataArray = @[].mutableCopy;
        _contentArray = @[@{@"name":@"科特琳娜", @"gender":@"女", @"professional":@"刺客", @"imageUrl":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4133911069,2636333741&fm=27&gp=0.jpg"},
                          @{@"name":@"盖伦", @"gender":@"男", @"professional":@"坦克", @"imageUrl":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3641732946,638287837&fm=27&gp=0.jpg"},
                          @{@"name":@"泰隆", @"gender":@"男", @"professional":@"刺客", @"imageUrl":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2159383493,3122315113&fm=27&gp=0.jpg"},
                          @{@"name":@"艾瑞莉娅", @"gender":@"女", @"professional":@"战士", @"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346659477&di=caa2913f17ce06c28d670fcdd4784d2e&imgtype=0&src=http%3A%2F%2Fi.17173cdn.com%2F2fhnvk%2FYWxqaGBf%2Fcms3%2FttsrNKbmjnlgycm.jpg%2521a-3-540x.jpg"},
                          @{@"name":@"泰达米尔", @"gender":@"男", @"professional":@"战士", @"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346807312&di=a3a28c5809cca124f2d0c965cf2cddd0&imgtype=0&src=http%3A%2F%2Fimg001.007fenqi.com%2Fseller%2Fb61d50d4378efc0fd4da7f501d18329d.jpg"},
                          @{@"name":@"艾希", @"gender":@"女", @"professional":@"adc", @"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346844500&di=f39860a6703b3d942077a538fe2146c7&imgtype=0&src=http%3A%2F%2Fwww.xz7.com%2Fup%2F2017-9%2F2017989545431530.jpg"},
                          @{@"name":@"亚索", @"gender":@"男", @"professional":@"刺客", @"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346914517&di=66a6339d652a4afd9afee45596e30dff&imgtype=0&src=http%3A%2F%2Fdown.52pk.com%2Fuploads%2F170616%2F5019_114202_1_lit.png"},
                          @{@"name":@"瑞文", @"gender":@"女", @"professional":@"战士", @"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346942493&di=ec0624e055ad2741000655b11283b91c&imgtype=0&src=http%3A%2F%2Fimg.smzy.com%2Fimges%2F2017%2F0616%2F20170616035845175.jpg"}].mutableCopy;
    }
    return self;
}

#pragma mark -- 获取数据 --
- (void)loadData
{

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i = 0; i < _contentArray.count; i ++) {
//            HHHomePageCellModel *model = [[HHHomePageCellModel alloc] init];
//            [model setValuesForKeysWithDictionary:_contentArray[i]];
//            [_dataArray addObject:model];
//        }
//        if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(requestDataCompleted)]) {
//            [self.myDelegate requestDataCompleted];
//        }
//    });
    for (int i = 0; i < _contentArray.count; i ++) {
        HHHomePageCellModel *model = [[HHHomePageCellModel alloc] init];
        [model setValuesForKeysWithDictionary:_contentArray[i]];
        [_dataArray addObject:model];
    }
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(requestDataCompleted)]) {
        [self.myDelegate requestDataCompleted];
    }
}

@end
