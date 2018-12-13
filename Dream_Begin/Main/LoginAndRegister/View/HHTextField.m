//
//  HHTextField.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/28.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#define padding 10
#define heightSpaceing 5

#import "HHTextField.h"

@interface HHTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIView *lineView;
//填充线
@property (nonatomic, strong) CALayer *lineLayer;
//移动一次
@property (nonatomic, assign) BOOL moved;

@end

@implementation HHTextField

static const CGFloat lineWidth = 1;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.borderStyle = UITextBorderStyleNone;
    _textField.font = [UIFont systemFontOfSize:15.0f];
    _textField.textColor = [UIColor whiteColor];
    _textField.delegate = self;
    _textField.tintColor = [UIColor whiteColor];
    [self addSubview:_textField];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholderLabel.font = [UIFont systemFontOfSize:13.0f];
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_placeholderLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    
    _lineLayer = [CALayer layer];
    _lineLayer.frame = CGRectMake(0, 0, 0, lineWidth);
    _lineLayer.anchorPoint = CGPointMake(0, 0.5);
    _lineLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [_lineView.layer addSublayer:_lineLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obserValue:) name:UITextFieldTextDidChangeNotification object:_textField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - lineWidth);
    _placeholderLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - lineWidth);
    _lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - lineWidth, CGRectGetWidth(self.frame), lineWidth);
}

- (void)obserValue:(NSNotification *)obj
{
    [self changeFrameOfPlaceholder];
}

- (void)changeFrameOfPlaceholder
{
    CGFloat x = _placeholderLabel.center.x;
    CGFloat y = _placeholderLabel.center.y;
    
    if (_textField.text.length != 0 && !_moved) {
        [self moveAnimationWithX:x y:y];
    } else if (_textField.text.length == 0 && _moved) {
        [self backAnimationWithX:x y:y];
    }
}

#pragma mark -- 动画 --
- (void)moveAnimationWithX:(CGFloat)x y:(CGFloat)y
{
    __block CGFloat moveX = x;
    __block CGFloat moveY = y;
    
    _placeholderLabel.font = [UIFont systemFontOfSize:18.0];
    _placeholderLabel.textColor = _placeholderSelectStateColor;
    
    [UIView animateWithDuration:0.15 animations:^{
        moveX -= padding;
        moveY -= _placeholderLabel.frame.size.height / 2 + heightSpaceing;
        _placeholderLabel.center = CGPointMake(moveX, moveY);
        _placeholderLabel.alpha = 1;
        _moved = YES;
        _lineLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame), lineWidth);
    }];
}

- (void)backAnimationWithX:(CGFloat)x y:(CGFloat)y
{
    __block CGFloat moveX = x;
    __block CGFloat moveY = y;
    
    [UIView animateWithDuration:0.15 animations:^{
        moveX += padding;
        moveY += _placeholderLabel.frame.size.height / 2 + heightSpaceing;
        _placeholderLabel.center = CGPointMake(moveX, moveY);
        _placeholderLabel.alpha = 1;
        _moved = NO;
        _lineLayer.bounds = CGRectMake(0, 0, 0, lineWidth);
    }];
}

#pragma mark -- setter方法 --
- (void)setHh_placeholder:(NSString *)hh_placeholder
{
    _hh_placeholder = hh_placeholder;
    _placeholderLabel.text = hh_placeholder;
}

- (void)setCursorColor:(UIColor *)cursorColor
{
    _textField.tintColor = cursorColor;
}

- (void)setPlaceholderNormalStateColor:(UIColor *)placeholderNormalStateColor
{
    if (!placeholderNormalStateColor) {
        _placeholderLabel.textColor = [UIColor whiteColor];
    } else {
        _placeholderLabel.textColor = placeholderNormalStateColor;
    }
}

- (void)setPlaceholderSelectStateColor:(UIColor *)placeholderSelectStateColor
{
    if (!placeholderSelectStateColor) {
        _placeholderSelectStateColor = [UIColor lightGrayColor];
    } else {
        _placeholderSelectStateColor = placeholderSelectStateColor;
    }
}

- (void)setIsSecureTextEntry:(BOOL)isSecureTextEntry
{
    _isSecureTextEntry = isSecureTextEntry;
    if (self.isSecureTextEntry == YES) {
        _textField.secureTextEntry = YES;
    }
}

@end
