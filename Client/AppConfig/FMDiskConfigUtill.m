//
//  FMDiskConfigUtill.m
//  Taidi
//
//  Created by eric on 2017/12/20.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "FMDiskConfigUtill.h"
#import <YYCache/YYDiskCache.h>
#import "FileTool.h"


NSString *const KUserInfoKeyName = @"KUserInfoKeyName";
@interface FMDiskConfigUtill()

@property(nonatomic,strong)YYDiskCache *diskCache;

@end



@implementation FMDiskConfigUtill
singtonImplement(FMDiskConfigUtill)


-(id)init{
    self = [super init];
    if (self) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _diskCache = [[YYDiskCache alloc] initWithPath:documentPath inlineThreshold:1024 * 1024 *10];
    }
    return self;
}

-(UserInfo *)getUserInfoConfig{
    UserInfo *_naviModel = (UserInfo *)[_diskCache objectForKey:KUserInfoKeyName];
    if (!_naviModel) {
        _naviModel = [[UserInfo alloc] init]; 
    }
    return _naviModel;
}

-(void)saveUserInfoModel:(id<NSCoding>)model{
    [_diskCache setObject:model forKey:KUserInfoKeyName];
}

@end


