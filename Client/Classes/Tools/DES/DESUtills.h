//
//  DESUtills.h
//  Taidi
//
//  Created by eric on 2017/5/24.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESUtills : NSObject
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
@end
