//
//  HHMineCell.m
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/21.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHMineCell.h"
#import "HHMineCellModel.h"

@interface HHMineCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowsImgView;

@end

@implementation HHMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initail];
    }
    return self;
}

- (void)initail{
    self.icon = [[UIImageView alloc] init];
    [self addSubview:self.icon];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#684092"];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:self.titleLabel];

    self.arrowsImgView = [[UIImageView alloc] init];
    [self addSubview:self.arrowsImgView];

    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.backgroundColor = [UIColor colorWithHexString:@"684092"];
    [self addSubview:self.lineLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.icon.mas_right).with.offset(15);
        make.height.equalTo(@(20));
    }];

    [self.arrowsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];

    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(16);
        make.right.equalTo(self).with.offset(-16);
        make.height.equalTo(@(0.5));
    }];
}

- (void)setModel:(HHMineCellModel *)model
{
    NSString *imageName = [NSString stringWithFormat:@"%@", model.imageName];
    self.icon.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
