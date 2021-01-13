//
//  FMBaseModel.m
//  Client
//
//  Created by mingo on 2018/6/5.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "FMBaseModel.h"

@implementation FMBaseModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

/// 左边对象的属性数组。右边是 class 名字
+(NSDictionary *)mj_objectClassInArray{
    return @{
             };
}

/// 左边是当前obj对象属性。右边是\\请求字典属性
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"description_field":@"description"

             };
}

@end
