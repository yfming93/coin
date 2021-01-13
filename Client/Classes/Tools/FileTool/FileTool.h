//
//  FileTool.h
//  Taidi
//
//  Created by 扆佳梁 on 2017/4/6.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject


/**
 获取Document 文件夹下面的路径

 @param filename 文件名
 @return 文件路径
 */
+(NSString *)documentDirPath:(NSString *)filename;


+(void)writeString:(NSString *)text ToFile:(NSString *)path;

+(void)writeString:(NSString *)text ToFile:(NSString *)path append:(BOOL)append;


+(NSString *)readStringFromFile:(NSString *)path;


+(void)deleteFileWith:(NSString *)path;
@end
