//
//  FMDiskConfigUtill.h
//  Taidi
//
//  Created by eric on 2017/12/20.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN
@interface FMDiskConfigUtill : NSObject

singtonInterface
-(UserInfo *)getUserInfoConfig;
-(void)saveUserInfoModel:(id<NSCoding>)model;

NS_ASSUME_NONNULL_END
@end
