//
//  Sington.h
//  application
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 stormorai. All rights reserved.
//


#define singtonInterface  + (instancetype)sharedInstance;



#define singtonImplement(class) \
\
static class *_sharedInstance; \
\
+ (instancetype)sharedInstance { \
\
    if(_sharedInstance == nil) {\
        _sharedInstance = [[class alloc] init]; \
    } \
    return _sharedInstance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone { \
\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _sharedInstance = [super allocWithZone:zone]; \
    }); \
\
    return _sharedInstance; \
\
}
