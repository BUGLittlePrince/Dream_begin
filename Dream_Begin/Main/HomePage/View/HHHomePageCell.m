//
//  HHHomePageCell.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/3.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHHomePageCell.h"
#import "HHHomePageCellModel.h"

@interface HHHomePageCell()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *professionalLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation HHHomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    _iconImgView = [[UIImageView alloc] init];
    _iconImgView.layer.cornerRadius = 20;
    _iconImgView.clipsToBounds = YES;
    [self addSubview:_iconImgView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor cyanColor];
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:_nameLabel];
    
    _genderLabel = [[UILabel alloc] init];
    _genderLabel.textColor = [UIColor lightGrayColor];
    _genderLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_genderLabel];
    
    _professionalLabel = [[UILabel alloc] init];
    _professionalLabel.textColor = [UIColor greenColor];
    _professionalLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_professionalLabel];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImgView.mas_top);
        make.left.equalTo(_iconImgView.mas_right).with.offset(16);
        make.height.equalTo(@(20));
    }];
    
    [_genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.equalTo(@(16));
    }];
    
    [_professionalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconImgView.mas_bottom);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.equalTo(@(16));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
}

- (void)setModel:(HHHomePageCellModel *)model
{
    _model = model;
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = model.name;
    _genderLabel.text = model.gender;
    _professionalLabel.text = model.professional;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
