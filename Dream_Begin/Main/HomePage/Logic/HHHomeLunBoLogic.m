//
//  HHHomeLunBoLogic.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/3.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHHomeLunBoLogic.h"
#import "HHHomeLunBoModel.h"

@interface HHHomeLunBoLogic()

@property (nonatomic, strong) NSMutableArray *imageUrlArray;

@end

@implementation HHHomeLunBoLogic

- (instancetype)init
{
    if (self = [super init]) {
//        _dataArray = @[].mutableCopy;
        _dataArray = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",
                           @"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",
                           @"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",
                           @"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",
                           @"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"].mutableCopy;
    }
    return self;
}

- (void)loadData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0 ;i < _imageUrlArray.count; i ++) {
//            HHHomeLunBoModel *model = [[HHHomeLunBoModel alloc] init];
//            model.imageUrl = _imageUrlArray[i];
//            [_dataArray addObject:model];
        }
    });
}

@end
