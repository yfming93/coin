//
//  GetImgBase64String.m
//  base64
//
//  Created by test on 16/3/11.
//  Copyright © 2016年 com.facishare.CoreTest. All rights reserved.
//

#import "GetImgBase64String.h"

@implementation GetImgBase64String
+ (NSString *)getImgBase64StringWithImgFilePath:(NSString*)imgFilePath
{
    return [[NSData dataWithContentsOfFile:imgFilePath]base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSString *)getImgBase64StringWithImg:(UIImage *)img
{
    return [GetImgBase64String getImgBase64StringWithImg:img Ratio:0.7];
}

+ (NSString *)getImgBase64StringWithImg:(UIImage *)img  Ratio:(CGFloat)ratio
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(img.CGImage);
    BOOL isAlphaImg = (alpha == kCGImageAlphaFirst || alpha == kCGImageAlphaLast ||  alpha == kCGImageAlphaPremultipliedFirst || alpha == kCGImageAlphaPremultipliedLast);
    NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Test%f%@",[[NSDate date] timeIntervalSince1970],(isAlphaImg ? @".png" : @".jpg")]];//拼接图片路径
    [(isAlphaImg ? UIImagePNGRepresentation(img) : UIImageJPEGRepresentation(img, ratio) )writeToFile:jpgPath atomically:YES];//写入文件
    NSString * base64String = [GetImgBase64String getImgBase64StringWithImgFilePath:jpgPath];
    [[NSFileManager defaultManager] removeItemAtPath:jpgPath error:nil];//删除文件
    return base64String;
}
@end
