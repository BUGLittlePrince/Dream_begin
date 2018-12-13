//
//  HHcontentView.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/9.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHContentView.h"

static NSString *kContentCellID = @"kContentCellID";

@interface HHContentView ()<UICollectionViewDelegate, UICollectionViewDataSource>

//所有自控制器
@property (nonatomic, copy) NSArray <UIViewController *> *childVCs;
//父控制器
@property (nonatomic, strong) UIViewController *parentVC;
//是否禁止scrollView拖动，防止两个代理产生死循环
@property (nonatomic, assign) BOOL isForbidScrollDelegate;
//开始滑动的位置
@property (nonatomic, assign) CGFloat startOffsetX;
//内容视图
@property (nonatomic, strong) UICollectionView *collectionView;
//标题样式
@property (nonatomic, strong) HHTitleStyleLogic *style;

@end

@implementation HHContentView

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        //点击设备的状态栏时，是scrollsToTop == YES的控件滚动返回至顶部
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
//        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - kTopHeight);
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
        _collectionView.backgroundColor = KWhiteColor;
        _collectionView.scrollEnabled = self.style.isContentViewScrollEnable;
    }
    return _collectionView;
}

- (HHContentView *)initWithFrame:(CGRect)frame childVCs:(NSArray<UIViewController *> *)childVCs parentViewController:(UIViewController *)parentViewController style:(HHTitleStyleLogic *)style
{
    if (self = [super initWithFrame:frame]) {
        self.childVCs = childVCs;
        self.parentVC = parentViewController;
        self.style = style;
        
        [self setupUI];
    }
    return self;
}

#pragma mark --添加组件--
- (void)setupUI
{
    //将所有的控制器添加到父控制器中
    for (UIViewController *childVC in self.childVCs) {
        [self.parentVC addChildViewController:childVC];
    }
    //添加到collectionView
    [self addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIViewController *childVC = self.childVCs[indexPath.item];
//    childVC.view.backgroundColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
    childVC.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVC.view];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidScrollDelegate = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是否有点击事件
    if (self.isForbidScrollDelegate) {
        return;
    }
    //定义获取需要的变量
    CGFloat progress = 0.0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    //判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    if (currentOffsetX > self.startOffsetX) {
        //左滑
        //计算progress
        progress = currentOffsetX / scrollViewW - floorl(currentOffsetX / scrollViewW);
        
        //计算sourceIndex
        sourceIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        //计算targetIndex
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVCs.count) {
            targetIndex = self.childVCs.count - 1;
            sourceIndex = self.childVCs.count - 1;
        }
        
        //如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1.0;
            targetIndex = sourceIndex;
        }
    } else {
        //右滑
        //计算progress
        progress = 1 - (currentOffsetX / scrollViewW - floorl(currentOffsetX / scrollViewW));
        
        //计算targetIndex
        targetIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        sourceIndex = targetIndex + 1;
        
        if (sourceIndex >= self.childVCs.count) {
            sourceIndex = self.childVCs.count - 1;
        }
    }
    
    if ([self.myDelegate respondsToSelector:@selector(contentViewWith:progress:sourceIndex:targetIndex:)]) {
        [self.myDelegate contentViewWith:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    //快速滑动之后，可能会出现偏差，需要重置
    if (currentOffsetX > self.startOffsetX && (currentOffsetX - self.startOffsetX >= scrollViewW)) {
        NSInteger sourceIndex = (NSInteger)(currentOffsetX / scrollViewW);
        NSInteger targetIndex = sourceIndex;
        CGFloat progress = 1.0;
        
        if (targetIndex >= self.childVCs.count) {
            targetIndex = self.childVCs.count - 1;
            sourceIndex = self.childVCs.count - 1;
        }
        
        if ([self.myDelegate respondsToSelector:@selector(contentViewWith:progress:sourceIndex:targetIndex:)]) {
            [self.myDelegate contentViewWith:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
        }
    }
    
    if ([self.myDelegate respondsToSelector:@selector( contentViewEndScrollWithContentView:)]) {
        [self.myDelegate contentViewEndScrollWithContentView:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        if ([self.myDelegate respondsToSelector:@selector(contentViewEndScrollWithContentView:)]) {
            [self.myDelegate contentViewEndScrollWithContentView:self];
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    //记录需要进行执行代理方法
    self.isForbidScrollDelegate = YES;
    
    //滚动到正确的位置
    CGFloat offsetX = currentIndex * self.collectionView.frame.size.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}

@end
