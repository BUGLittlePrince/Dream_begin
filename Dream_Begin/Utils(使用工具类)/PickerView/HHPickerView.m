//
//  HHPickView.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHPickerView.h"

@interface HHPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

//关闭
@property (nonatomic, strong) UIButton *cancelBtn;
//确认
@property (nonatomic, strong) UIButton *confirmBtn;
//导航包含视图
@property (nonatomic, strong) UIView *naviContainView;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//pickerView
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UIView *mainView;

@end

@implementation HHPickerView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViews];
        self.titleLabel.text = title;
    }
    return self;
}

- (void)setupChildViews
{
    [self addSubview:self.bgButton];
    [self addSubview:self.mainView];
    
    [self.mainView addSubview:self.naviContainView];
    [self.naviContainView addSubview:self.cancelBtn];
    [self.naviContainView addSubview:self.titleLabel];
    [self.naviContainView addSubview:self.confirmBtn];
    [self.mainView addSubview:self.pickerView];
    
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.mainView setFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 260)];
    [self.naviContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.mainView);
        make.height.mas_equalTo(44);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.equalTo(self.naviContainView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.naviContainView);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.equalTo(self.naviContainView);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviContainView.mas_bottom);
        make.left.right.bottom.equalTo(self.mainView);
    }];
}

#pragma mark -- private methods（私有方法） --
- (void)cancelAction:(UIButton *)btn
{
    [self dismiss];
}

- (void)confirmAction:(UIButton *)btn
{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(pickerView:confirmButtonClick:)]) {
        [self.delegate pickerView:self confirmButtonClick:btn];
    }
}

#pragma mark -- public methods（共有方法） --
- (void)show
{
    self.bgButton.alpha = 0.3;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.top = KScreenHeight - 260;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.top = KScreenHeight;
        self.bgButton.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [self.pickerView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return [self.pickerView selectedRowInComponent:component];
}

#pragma mark -- 代理方法、数据方法 --
- (NSInteger)numberOfComponentsInPickerView:(HHPickerView *)pickerView{
    return [self.dataSource numberOfComponentsInPickerView:self];
}

- (NSInteger)pickerView:(HHPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource pickerView:self numberOfRowsInComponent:component];
}

- (NSString *)pickerView:(HHPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [self.delegate pickerView:self titleForRow:row forComponent:component];
    } else {
        return @"";
    }
}

- (void)pickerView:(HHPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        return [self.delegate pickerView:self didSelectRow:row inComponent:component];
    }
}

- (NSAttributedString *)pickerView:(HHPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]) {
        return [self.delegate pickerView:self attributedTitleForRow:row forComponent:component];
    } else {
        return nil;
    }
}

- (void)pickReloadComponent:(NSInteger)component
{
    [self.pickerView reloadComponent:component];
}

- (void)reloadDate
{
    [self.pickerView reloadAllComponents];
}

#pragma mark -- getter methods 懒加载 --
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:HHColor(85, 85, 85, 1) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_cancelBtn sizeToFit];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:HHColor(255, 126, 0, 1) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_confirmBtn sizeToFit];
    }
    return _confirmBtn;
}

- (UIView *)naviContainView
{
    if (!_naviContainView) {
        _naviContainView = [[UIView alloc] init];
        _naviContainView.backgroundColor = [UIColor whiteColor];
    }
    return _naviContainView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"title";
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)bgButton
{
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor blackColor];
        _bgButton.alpha = 0.3;
        [_bgButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

@end
