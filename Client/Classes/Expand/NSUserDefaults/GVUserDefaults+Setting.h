//
//  GVUserDefaults+Setting.h
//  application
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 stormorai. All rights reserved.
//

#import "GVUserDefaults.h"

@interface GVUserDefaults (Setting)

/// 唤醒是否打开
@property(nonatomic, assign) BOOL isWakeUpOpen;

@property(nonatomic, assign) BOOL devDebugState;
@property(nonatomic, copy) NSString *debugDomain;
/// 不是第一次安装
@property(nonatomic, assign) BOOL notFirstInstall;
@property(nonatomic, assign) BOOL isSetTouchId;
proBool(isLoginSuccess)
proNSString(klineUrlHost)
@end
