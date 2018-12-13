//
//  UICollectionView+HHIndexPath.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/24.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "UICollectionView+HHIndexPath.h"
#import <objc/runtime.h>

static NSString * const kIndexPathKey = @"kIndexPathKey";

@implementation UICollectionView (HHIndexPath)

- (void)setCurrentIndexPath:(NSIndexPath *)indexPath
{
    //通过此函数保存indexPath
    objc_setAssociatedObject(self, &kIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)currentIndexPath
{
    NSIndexPath *indexPath = objc_getAssociatedObject(self, &kIndexPathKey);
    return indexPath;
}

@end
