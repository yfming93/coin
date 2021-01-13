//
//  Setting.m
//  application
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 stormorai. All rights reserved.
//

#import "Setting.h"


@implementation Setting

singtonImplement(Setting)

NSString *const KUUIDStringName = @"KUUIDStringName";

#pragma mark - 后台接口地址

#pragma mark - 各种路径


#pragma mark - 私有方法


//-(NSString *)deviceId{
//
//    if (!_deviceId) {
//        _deviceId =[self st_getUUID];
//    }
//    return _deviceId;
//}

//-(NSString *)st_getUUID{
//
//    NSString *idfaStr = [KeyChainUtill load:KUUIDStringName];
//    if (!idfaStr) {
//        idfaStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        [KeyChainUtill save:KUUIDStringName data:idfaStr];
//    }
//    KKLog(@"当前uuid = %@",idfaStr);
//    return idfaStr;
//}

-(UserInfo *)userInfo {
    if (_userInfo == nil) {
        _userInfo = UserInfo.new;
    }
    return _userInfo;
}




@end
