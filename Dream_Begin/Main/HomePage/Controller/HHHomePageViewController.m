//
//  HHHomePageViewController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/26.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHHomePageViewController.h"
#import "HHHomePageCell.h"
#import "HH3DBannerView.h"

#define identifier @"cellID"

@interface HHHomePageViewController ()<UITableViewDelegate, UITableViewDataSource, HHHomePageLogicDelegate>

@end

@implementation HHHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLogic];
    
    [self setupTableView];
    self.view.backgroundColor = [UIColor redColor];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupLogic
{
    _logic = [HHHomePageLogic new];
    _logic.myDelegate = self;
    
    _lunBoLogic = [HHHomeLunBoLogic new];
}

- (void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HHHomePageCell class] forCellReuseIdentifier:identifier];
    UIDevice *device = [[UIDevice alloc] init];
    BOOL isIphoneX = [device isIphoneX];
    CGFloat height = 0;
    if (isIphoneX) {
        height = 44;
    } else {
        height = 32;
    }
    self.tableView.frame = CGRectMake(0, height, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight - 44);
    [self.view addSubview:self.tableView];
    
    HH3DBannerView *lunBoView = [HH3DBannerView initWithFrame:CGRectMake(0, 0, KScreenWidth, 150) imageSpacing:10 imageWidth:kScreenWidth - 50];
    lunBoView.data = _lunBoLogic.dataArray.mutableCopy;
    //设置原始透明度(两端卡片的透明度)
    lunBoView.initAlpha = 0.5;
    lunBoView.imageRadius = 10;
    //中间卡片与两边卡片的高度差
    lunBoView.imageHeightPoor = 10;
    self.tableView.tableHeaderView = lunBoView;
    //点击中间图片的回调
    lunBoView.clickImageBlock = ^(NSInteger currentIndex) {
        
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _logic.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.model = _logic.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshing
{
    [super headerRefreshing];
    [_logic.dataArray removeAllObjects];
    [_logic loadData];
}

#pragma mark -- 上拉加载 --
- (void)footerRefreshing
{
    [super footerRefreshing];
    [_logic loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 逻辑代理 --
- (void)requestDataCompleted
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

@end
