//
//  HHMineCell.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/21.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHMineCellModel;

@interface HHMineCell : UITableViewCell

@property (nonatomic, strong) HHMineCellModel *model;
@property (nonatomic, strong) UILabel *lineLabel;

@end
