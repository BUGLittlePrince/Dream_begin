//
//  HHPickView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHPickerView;

@protocol HHPickerViewDataSource <NSObject>

@required
- (NSInteger)numberOfComponentsInPickerView:(HHPickerView *)pickerView;
- (NSInteger)pickerView:(HHPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol HHPickerViewDelegate <NSObject>

- (NSString *)pickerView:(HHPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(HHPickerView *)pickerView confirmButtonClick:(UIButton *)button;

@optional
- (NSAttributedString *)pickerView:(HHPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(HHPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface HHPickerView : UIView

@property (nonatomic, weak) id<HHPickerViewDelegate> delegate;
@property (nonatomic, weak) id<HHPickerViewDataSource> dataSource;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)show;
- (void)dismiss;
//选中某一行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
//获取当前选中的row
- (NSInteger)selectedRowInComponent:(NSInteger)component;
//刷新某列数据
- (void)pickReloadComponent:(NSInteger)component;
//刷新数据
- (void)reloadDate;

@end
