//
//  HHMyPlanDetailsVC.m
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHMyPlanDetailsVC.h"

@interface HHMyPlanDetailsVC ()

@end

@implementation HHMyPlanDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBarItems];
    [self setupSubviews];
}

- (void)setupBarItems{
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 26, 26);
    [collectBtn setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collectionClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectionBarItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];

    UIBarButtonItem *fixedSpaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarItem.width = 22;

    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 26, 26);
    [shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];

    self.navigationItem.rightBarButtonItems = @[shareBarItem,fixedSpaceBarItem, collectionBarItem];
}

//收藏事件
- (void)collectionClick:(UIButton *)sender
{

}

//分享事件
- (void)shareClick:(UIButton *)sender
{
    
}

- (void)setupSubviews
{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    saveBtn.layer.cornerRadius = 10;
//    saveBtn.layer.masksToBounds = YES;
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexString:@"684092"]];
    [saveBtn addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, 40));
    }];
}

- (void)saveData
{
    if (self.block) {
        self.block(self.statu);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
