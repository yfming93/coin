//
//  AttributedStringTool.h
//  Client
//
//  Created by mingo on 2018/6/14.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributedStringTool : NSObject

/**
 图文混排 图片在最前
 
 @param str 初始文字
 @param font 字号
 @param image 插入图片
 @param rect 图片尺寸
 @return 返回的富文本
 */
+(NSMutableAttributedString *)changeImgaeWithFirst:(NSString *)str andStrFont:(UIFont *)font andImage:(UIImage *)image andImageFrame:(CGRect)rect;

+(NSMutableAttributedString *)fm_changeImgaeWithFirst:(NSString *)str andStrFont:(UIFont *)font andImageLabText:(NSString *)imageText;

/**
  图文混排 图片在最后

 @param str 初始文字
 @param font 字号
 @param image 插入图片
 @param rect 图片尺寸
 @return 返回的富文本
 */
+(NSMutableAttributedString *)changeImgaeWithLast:(NSString *)str andStrFont:(UIFont *)font andImage:(UIImage *)image andImageFrame:(CGRect)rect;


/**
 两色文字

 @param str 初始文字
 @param integer 分割处
 @param font 第一段字号
 @param firstColcor 第一段背景颜色
 @param firstLabelColor 第一段文字颜色
 @param lastfont 最后一段文字字号
 @param lastColcor 最后一段背景颜色
 @param lastLabelColor 最后一段文字颜色
 @return 返回的富文本
 */
+(NSMutableAttributedString *)changeLabelColor:(NSString *)str
                               andRangLocation:(NSUInteger)integer
                                  andFirstFont:(UIFont *)font
                            andBackGroundColor:(UIColor *)firstColcor
                            andFirstLabelColor:(UIColor *)firstLabelColor
                                   andLastFont:(UIFont *)lastfont
                        andlastBackGroundColor:(UIColor *)lastColcor
                             andlastLabelColor:(UIColor *)lastLabelColor;


/**
 文字阴影效果

 @param str 传入文字
 @return 返回富文本
 */
+(NSMutableAttributedString *)changeLabelYingyin:(NSString *)str;

@end
