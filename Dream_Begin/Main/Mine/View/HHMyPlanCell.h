//
//  HHMyPlanCell.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/22.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHMyPlanModel.h"

@interface HHMyPlanCell : UICollectionViewCell

/*任务图片*/
@property (nonatomic, strong) UIImageView *iconIV;
/*线圈*/
@property (nonatomic, strong) UIImageView *iconBorder;
/*任务名称*/
@property (nonatomic, strong) UILabel *nameLB;
/*进行中*/
@property (nonatomic, strong) UILabel *progressLB;
//上线
@property (nonatomic, strong) UIView *topLine;
//下线
@property (nonatomic, strong) UIView *downLine;
//左线
@property (nonatomic, strong) UIView *leftLine;
//右线
@property (nonatomic, strong) UIView *rightLine;
-(void)cellIndexPathRow:(NSInteger)row rowCount:(NSInteger)count;
@property (nonatomic,strong) HHMyPlanModel *dataModel;
@property (nonatomic,strong) HHMyPlanModel *statueModel;

@end
