//
//  AttributedStringTool.m
//  Client
//
//  Created by mingo on 2018/6/14.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "AttributedStringTool.h"


@implementation AttributedStringTool

+(NSMutableAttributedString *)changeImgaeWithFirst:(NSString *)str andStrFont:(UIFont *)font andImage:(UIImage *)image andImageFrame:(CGRect)rect
{
    NSString *words = str;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:words attributes:@{NSFontAttributeName : font}];
    NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attatch.bounds = CGRectMake(0, 0, 40, 17);
    attatch.image = FM_IMAGE(@"bj-pre");
    NSTextAttachment *attatch1 = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attatch1.bounds = CGRectMake(0, 0, 40, 17);
    attatch1.image = FM_IMAGE(@"bj-pre");
    NSAttributedString *string8 = [NSAttributedString attributedStringWithAttachment:attatch];
    NSAttributedString *string9 = [NSAttributedString attributedStringWithAttachment:attatch1];
//    [strAtt insertAttributedString:string8 atIndex:1];
    [strAtt insertAttributedString:string9 atIndex:0];
    
    return strAtt;
//    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : font}];
//    NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
//    attatch.bounds = rect;
//    attatch.image = image;
//
//    NSAttributedString *string8 = [NSAttributedString attributedStringWithAttachment:attatch];
//
//    [strAtt insertAttributedString:string8 atIndex:1];
//    return strAtt;
    
    
}

+(NSMutableAttributedString *)fm_changeImgaeWithFirst:(NSString *)str andStrFont:(UIFont *)font andImageLabText:(NSString *)imageText {
    NSString *words = str;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:words attributes:@{NSFontAttributeName : font}];
    NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UILabel *lab = [UILabel fm_initUIlabelWithTextColor:kOrangeColor backColor:UIColor.clearColor textAlignment_Left0_Center1_Right2:1 font:12 cornerRadius:3 addToSuperView:nil title:imageText];
    lab.layer.borderColor = kOrangeColor.CGColor;
    lab.layer.borderWidth = 0.4f;
    CGFloat padding = 15 ,labW;
    labW = padding * imageText.length;
    [lab setFrame:CGRectMake(0, 0, labW, 14)];
    UIImage *ima =  [self fm_snapshotSingleView:lab];
    attatch.bounds = CGRectMake(0, -2, labW, lab.height);
    attatch.image = ima;
    NSAttributedString *string8 = [NSAttributedString attributedStringWithAttachment:attatch];
    [strAtt insertAttributedString:string8 atIndex:0];
    
    return strAtt;
    
}

/// 截图指定view成图片
+ (UIImage *)fm_snapshotSingleView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


+(NSMutableAttributedString *)changeImgaeWithLast:(NSString *)str andStrFont:(UIFont *)font andImage:(UIImage *)image andImageFrame:(CGRect)rect
{
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : font}];
    NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attatch.bounds = rect;
    attatch.image = image;
    
    NSAttributedString *string8 = [NSAttributedString attributedStringWithAttachment:attatch];
    
    [strAtt insertAttributedString:string8 atIndex:str.length];
    return strAtt;
}

+(NSMutableAttributedString *)changeLabelColor:(NSString *)str
                               andRangLocation:(NSUInteger)integer
                                  andFirstFont:(UIFont *)font
                            andBackGroundColor:(UIColor *)firstColcor
                            andFirstLabelColor:(UIColor *)firstLabelColor
                                  andLastFont:(UIFont *)lastfont
                            andlastBackGroundColor:(UIColor *)lastColcor
                            andlastLabelColor:(UIColor *)lastLabelColor
{
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置第一段
    //文字颜色
    [string addAttribute:NSForegroundColorAttributeName value:firstLabelColor range:NSMakeRange(0, integer)];
    //字体大小
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, integer)];
    //背景色
    [string addAttribute:NSBackgroundColorAttributeName value:firstColcor range:NSMakeRange(0, integer)];
    
    // 设置第二段
    [string addAttribute:NSForegroundColorAttributeName value:lastLabelColor range:NSMakeRange(integer, str.length - integer)];
    [string addAttribute:NSFontAttributeName value:lastfont range:NSMakeRange(integer, str.length - integer)];
    [string addAttribute:NSBackgroundColorAttributeName value:lastColcor range:NSMakeRange(integer, str.length - integer)];
    
    return string;
}

+(NSMutableAttributedString *)changeLabelYingyin:(NSString *)str{
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 创建NSShadow实例
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor purpleColor];
    shadow.shadowBlurRadius = 3.0;
    shadow.shadowOffset = CGSizeMake(0, 0.8);
    // 添加属性
    [attributeStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, str.length)];
    return attributeStr;
}



@end
