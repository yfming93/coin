//
//  GetImgBase64String.h
//  base64
//
//  Created by test on 16/3/11.
//  Copyright © 2016年 com.facishare.CoreTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetImgBase64String : NSObject
/**
 *  通过图片路径获取Base64 String，无损
 *
 *  @param imgFilePath 图片文件路径
 *
 *  @return Base64 String对象
 */
+ (NSString *)getImgBase64StringWithImgFilePath:(NSString*)imgFilePath;

/**
 *  通过UIimage获取图片的Base64 String , 采用0.7的压缩比，尽可能保证图片质量的情况下缩小体积，但是仍比 getImgBase64StringWithImgFilePath：imgFilePath方法得到的体积不一样，原因是因为UIImage的特殊性，有兴趣可以研究，此处不细讲。
 *
 *  注：压缩比仅对jpg格式有效
 *
 *  @param img UIImage对象
 *
 *  @return Base64 String对象
 */
+ (NSString *)getImgBase64StringWithImg:(UIImage *)img;

/**
 *  通过UIimage获取图片的Base64 String , 可自行设定压缩比，压缩比参照getImgBase64StringWithImg: img注释。
 *
 *  @param img   UIImage对象
 *  @param ratio 压缩比
 *
 *  @return Base64 String对象
 */
+ (NSString *)getImgBase64StringWithImg:(UIImage *)img  Ratio:(CGFloat)ratio;
@end
