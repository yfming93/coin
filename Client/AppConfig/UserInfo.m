//
//  UserInfo.m
//  application
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 stormorai. All rights reserved.
//

#import "UserInfo.h"
#import <FMCategoryKit/FMCategoryKitNSString.h>
#import <YYModel.h>

@implementation account


@end

@implementation User


@end


@implementation UserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder];}
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }

-(account *)account {
    if (_account == nil) {
        _account = account.new;
    }
    return _account;
}


- (NSMutableArray *)arrHistory{
    if (!_arrHistory) {
        _arrHistory = [NSMutableArray.alloc  init];
    }
    return _arrHistory;
}

/// 左边是当前obj对象属性。右边是\\请求字典属性
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"authorization":@"token"
             };
}




@end

@implementation member


@end
