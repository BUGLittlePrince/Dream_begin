//
//  HHMineViewController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/26.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHMineViewController.h"
#import "HHMyCollectVC.h"
#import "HHMyFootprintVC.h"
#import "HHMineCell.h"
#import "HHMineCellModel.h"
#import "HHMyPlanVC.h"
#import "HHPopView.h"

#define HeaderHeight 160
#define HeadImageViewHeight 276
#define Identify @"cellID"

@interface HHMineViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger selectTag;
    NSArray *titleArr;
    NSArray *numberArr;
    UIView *sectionView;

}
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UIImageView *avartImageV;
@property (nonatomic, assign) CGRect origialFrame;
@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *  按钮选中,中间值
 */
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation HHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = CNavBgColor;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    selectTag = 0;
    titleArr = @[@"我的收藏",@"我的足迹"];
    numberArr = @[@0, @20];
    [self.view addSubview:[self imageview]];
    [self.view addSubview:[self tableView]];
    [self setupRightBarItem];
    [self addHeadView];

    [self initailSectionView];

}

- (void)loadData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"mineList" ofType:@"plist"];
    array = [[NSMutableArray alloc] initWithContentsOfFile:dataPath];
    for (NSArray *arr in array) {
        NSMutableArray *arrayA = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            HHMineCellModel *model = [[HHMineCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [arrayA addObject:model];
        }
        [self.dataArray addObject:arrayA];
    }
}

- (void)setupRightBarItem
{
    //bug解决：在iOS11下，直接设置UIButton的frame是没有作用的
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(0, 0, 26, 26);
    [settingBtn setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];

    UIView *rightCustomView = [[UIView alloc] initWithFrame:settingBtn.frame];
    [rightCustomView addSubview:settingBtn];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightCustomView];
}

#pragma mark --设置--
- (void)settingAction{

}

- (void)initailSectionView
{
    sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    sectionView.backgroundColor=[UIColor colorWithHexString:@"#00008B"];

    for (int i=0; i<2; i++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i * kScreenWidth/2, 0, kScreenWidth / 2, 80)];
        backView.tag = 1000 + i;
        [sectionView addSubview:backView];

        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(backView.frame), 20)];
        titleLab.text = titleArr[i];
        titleLab.font = [UIFont systemFontOfSize:18.0];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:titleLab];

        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLab.frame) + 10, CGRectGetWidth(titleLab.frame), 20)];
        numberLabel.text = [NSString stringWithFormat:@"%@", numberArr[i]];
        numberLabel.font = [UIFont systemFontOfSize:14.0];
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:numberLabel];

        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backView.frame), 80)];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        if (i==0) {
            btn.selected=YES;
            self.selectedBtn=btn;
        }else{
            btn.selected=NO;
        }
    }
    
    UIImageView *memberImgV = [[UIImageView alloc] init];
    memberImgV.image = [UIImage imageNamed:@"member_1"];
    memberImgV.userInteractionEnabled = YES;
    [sectionView addSubview:memberImgV];
    [memberImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sectionView);
        make.centerY.equalTo(sectionView.mas_top);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popupPrompt)];
    [memberImgV addGestureRecognizer:tap];

    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    [sectionView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(memberImgV.mas_bottom);
        make.centerX.equalTo(memberImgV);
        make.width.equalTo(@(1));
        make.bottom.equalTo(sectionView.mas_bottom);
    }];
}

//弹出提示框
- (void)popupPrompt
{
//    HHPromptBox *propmtBox = [[HHPromptBox alloc] initCustomPromptBoxWithTitle:@"提示" contentStr:@"看看效果" andTop:KScreenHeight * 0.5 alpha:0.5];
//    NSLog(@"点击了");
//    [propmtBox showPromptBox:YES];
    HHPopView *alertView = [[HHPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.sharePictureImageUrlStr = @"https://img4.duitang.com/uploads/item/201512/15/20151215200047_tkjR4.thumb.700_0.jpeg";
    [alertView show];
}

- (UIImageView *)imageview{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeadImageViewHeight)];
        _headerImageView.image = [UIImage imageNamed:@"bg_1"];
        self.origialFrame = _headerImageView.frame;
    }
    return _headerImageView;
}
- (UITableView *)tableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - kTabBarHeight - kTopHeight) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor=[UIColor clearColor];
        _listTableView.showsVerticalScrollIndicator = NO;
        [_listTableView registerClass:[HHMineCell class] forCellReuseIdentifier:Identify];
        _listTableView.rowHeight = 50;
    }
    return _listTableView;
}

-(void)addHeadView{
    UIView *headView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeadImageViewHeight)];
    headView.backgroundColor =[UIColor clearColor];
    headView.userInteractionEnabled = YES;

    UIImageView *headPho=[[UIImageView alloc] init];
    headPho.layer.cornerRadius = 50;
    headPho.clipsToBounds = YES;
    [headView addSubview:headPho];
    [headPho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 100, 160, 200, 20)];
    name.font=[UIFont systemFontOfSize:16];
    name.textColor=[UIColor whiteColor];
    name.textAlignment=1;
    [headView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headPho.mas_bottom).with.offset(15);
        make.centerX.equalTo(headPho);
        make.height.equalTo(@(20));
    }];

    UILabel *signatureLabel=[[UILabel alloc] init];
    signatureLabel.font=[UIFont systemFontOfSize:14];
    signatureLabel.textColor=[UIColor whiteColor];
    signatureLabel.textAlignment=1;
    signatureLabel.numberOfLines = 0;
    [headView addSubview:signatureLabel];
    [signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).with.offset(15);
        make.centerX.equalTo(headView.mas_centerX);
        make.width.equalTo(@(200));
    }];

    self.listTableView.tableHeaderView = headView;
    //赋值
    headPho.image= [UIImage imageNamed:@"avart"];
    name.text=@"刀锋之影";
    signatureLabel.text=@"除了弱小以外，你们还有拿得出手的东西吗";

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = ((NSArray *)_dataArray[section]).count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HHMineCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify forIndexPath:indexPath];

    HHMineCellModel *model = _dataArray[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section ==0 && indexPath.row == 3) {
        cell.lineLabel.hidden = YES;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {

        } else if (indexPath.row == 1) {
            HHMyPlanVC *planVC = [[HHMyPlanVC alloc] init];
            [self.navigationController pushViewController:planVC animated:YES];
        } else if (indexPath.row == 2) {

        } else {

        }
    } else {
        if (indexPath.row == 0) {

        } else if (indexPath.row == 1) {

        } else {

        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 80;
    }
    return 20;

}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return sectionView;
    } else {
        UIView *sectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        sectionV.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        return sectionV;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //往上滑动offset增加，往下滑动，yoffset减小
    CGFloat yoffset = scrollView.contentOffset.y;
    //处理背景图的放大效果和往上移动的效果
    if (yoffset > 0) {//往上滑动

        _headerImageView.frame = ({
            CGRect frame = self.origialFrame;
            frame.origin.y = self.origialFrame.origin.y - yoffset;
            frame;
        });

    } else {//往下滑动，放大处理
        _headerImageView.frame = ({
            CGRect frame = self.origialFrame;
            frame.size.height = self.origialFrame.size.height - yoffset;
            frame.size.width = frame.size.height*1.5;
            frame.origin.x = _origialFrame.origin.x - (frame.size.width-_origialFrame.size.width)/2;
            frame;
        });
    }
}
-(void)selectBtn:(UIButton*)sender{
    selectTag=sender.tag;
    if (selectTag == 1000) {
        HHMyCollectVC *collectVC = [[HHMyCollectVC alloc] init];
        [self.navigationController pushViewController:collectVC animated:YES];
    } else {
        HHMyFootprintVC *footprintVC = [[HHMyFootprintVC alloc] init];
        [self.navigationController pushViewController:footprintVC animated:YES];
    }
}

#pragma mark --懒加载--
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
