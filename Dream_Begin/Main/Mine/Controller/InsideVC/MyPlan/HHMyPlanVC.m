//
//  HHMyPlanVC.m
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/22.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHMyPlanVC.h"
#import "HHMyPlanCell.h"
#import "HHMyPlanModel.h"
#import "HHMyPlanDetailsVC.h"

@interface HHMyPlanVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *changeIndexArr;
@property (nonatomic, assign) NSInteger currentSelectCnt; //当前选择的那天
@property (nonatomic, assign) NSInteger statu;
@property (nonatomic, strong) NSMutableArray *statusArray;

@end

static NSString *cellID = @"CollectionViewCell";

@implementation HHMyPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的计划";
    self.statu = 0;

    [self loadData];
    [self initailCollectionView];
}

#pragma mark --获取数据--
- (void)loadData
{
    for (int i = 0; i < 30; i++) {
        HHMyPlanModel *model = [[HHMyPlanModel alloc] init];
        model.isComplete = NO;
        model.isSelected = YES;
//        if (i == 0) {
//            model.isSelected = YES;
//        } else {
//            model.isSelected = NO;
//        }
        model.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        model.text = [NSString stringWithFormat:@"第%d项", i + 1];
        [self.dataSource addObject:model];
        [self.changeIndexArr addObject:[NSString stringWithFormat:@"%d", i]];
    }

    if (self.dataSource.count == 30) {
        for (int i = 0; i < self.dataSource.count; i ++) {
            //替换位置
            //i % 6 != 0 该行不交换
            NSInteger a = i % 3;
            if (i > 2 && a == 0 && i + 2 < self.dataSource.count && i % 6 != 0) {
                [self.changeIndexArr exchangeObjectAtIndex:i withObjectAtIndex:i + 2];
            }
        }
    }

    [self.collectionView reloadData];
}

#pragma mark --初始化collectionView--
- (void)initailCollectionView
{
    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.width/3);
    layout.minimumLineSpacing =  0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    UIImage *image = [UIImage imageNamed:@"planBG"];
    self.collectionView.layer.contents = (id)image.CGImage;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[HHMyPlanCell class] forCellWithReuseIdentifier:cellID];
    self.currentSelectCnt = 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    } else {
        return 0;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHMyPlanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    NSString *index = [NSString stringWithFormat:@"%@", self.changeIndexArr[indexPath.row]];
    HHMyPlanModel *model = [self.dataSource objectAtIndex:[index integerValue]];
    [cell cellIndexPathRow:indexPath.row rowCount:self.dataSource.count - 1];
    cell.dataModel = model;
    cell.statueModel = model;
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index = [NSString stringWithFormat:@"%@",self.changeIndexArr[indexPath.row]];
    self.currentSelectCnt = [index intValue];
    HHMyPlanDetailsVC *planDetailVC = [[HHMyPlanDetailsVC alloc] init];
    planDetailVC.block = ^(NSInteger statu) {
        self.statu = statu;
    };
    planDetailVC.statu = self.statu;
    [self.navigationController pushViewController:planDetailVC animated:YES];
}

#pragma mark --第一个未完成的--
- (NSInteger)firstDidNotFinishIndex
{
    NSInteger index = 10000;
    for (int i = 0; i < self.dataSource.count; i ++) {
        HHMyPlanModel *model = self.dataSource[i];
        if (!model.isComplete) {
            index = i;
            break;
        }
    }
    return index;
}
//完成任务总数
- (NSInteger)haveFinishCount
{
    NSInteger allCount = 0;
    for (int i = 0; i < self.dataSource.count; i ++) {
        HHMyPlanModel *model = self.dataSource[i];
        if (model.isComplete) {
            allCount ++;
        }
    }
    return allCount;
}

#pragma mark --懒加载--

- (NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [[NSMutableArray alloc] init];
    }
    return _statusArray;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSMutableArray *)changeIndexArr
{
    if (!_changeIndexArr) {
        _changeIndexArr = [[NSMutableArray alloc] init];
    }
    return _changeIndexArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
