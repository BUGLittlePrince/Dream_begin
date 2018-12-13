//
//  HHHeaderModel.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/19.
//  Copyright © 2018年 hanhong. All rights reserved.
//


#import "HHHeaderModel.h"

@implementation HHHeaderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.userId = userManager.curUserInfo.userId;
    self.imei = [OpenUDID value].length > 32 ? [[OpenUDID value] substringToIndex:32] : [OpenUDID value];
    self.os_type = 2;
    self.version = kApplication.appVersion;
    self.clientId = self.imei;
    self.versioncode = KVersionCode;
    self.mobile_model = [UIDevice currentDevice].machineModelName;
    self.mobile_brand = [UIDevice currentDevice].machineModel;
}

@end
