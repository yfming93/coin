//
//  Setting.h
//  application
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 stormorai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sington.h"
#import "UserInfo.h"
typedef NS_ENUM(NSInteger, SettingType) {
    SettingTypeLoginSuccess = 1,
};

typedef void (^SettingBlock)(SettingType type);
@interface Setting : NSObject
/// 用户信息数据
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, copy) SettingBlock settingBlock;
singtonInterface
@end
