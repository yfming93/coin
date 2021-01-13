//
//  FileTool.m
//  Taidi
//
//  Created by 扆佳梁 on 2017/4/6.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "FileTool.h"

@implementation FileTool


+(NSString *)documentDirPath:(NSString *)filename{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentPath stringByAppendingPathComponent:filename];
}

+(void)writeString:(NSString *)text ToFile:(NSString *)path append:(BOOL)append{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *newPath =  [path stringByDeletingLastPathComponent];
    
    BOOL isDir = YES;
    if ([manager fileExistsAtPath:newPath isDirectory:&isDir]) {
        
        
        if (append) {
         
            if(![manager fileExistsAtPath:path]) //如果不存在
            {
                
                [text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
            }else{
                NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
                
                [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
                
                NSData* stringData  = [text dataUsingEncoding:NSUTF8StringEncoding];
                
                [fileHandle writeData:stringData]; //追加写入数据
                
                [fileHandle closeFile];
                
            }

        }else{
            [text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
    }
    
}

+(void)writeString:(NSString *)text ToFile:(NSString *)path{
    
    [FileTool writeString:text ToFile:path append:YES];
    
}

+(NSString *)readStringFromFile:(NSString *)path{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *text = nil;
    if ([manager fileExistsAtPath:path]) {
        text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }

    return text;
    
    
}

+(void)deleteFileWith:(NSString *)path{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    
    
}
@end
