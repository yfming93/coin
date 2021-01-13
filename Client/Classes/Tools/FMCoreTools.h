//
//  Tools.h
//  PovertyAlleviation_OC
//
//  Created by TongHu on 2017/11/30.
//  Copyright © 2017年 tonghu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMCoreTools : NSObject

//年月日 时分秒
+ (NSString *)interceptTimeStampFromStr:(NSString *)str;
//到年月日
+ (NSString *)interceptTwoTimeStampFromStr:(NSString *)str;
//年月
+ (NSString *)interceptThreeTimeStampFromStr:(NSString *)str;
//到年
+ (NSString *)interceptFourTimeStampFromStr:(NSString *)str;


/**
 比对时间
 @param aDate 传入时间
 @return 比较两个日期的大小  日期格式为2016-08-14 08：46：20 （0：相等   1：传入时间大   -1：传入时间小）
 */
+ (NSInteger)compareDate:(NSDate *)aDate;

//判断完时间后，当前时间+14分钟的的时间：（token用于比对）
+ (NSDate *)getCurrentTime;

//当前时间
+(NSString *)makeTime;
+(NSString *)makeYear;
+(NSString *)makeYearMonth;
+(NSString *)makeMonth;
+(NSString *)makeYearMonthDayhms;


//计算字符串高度
+ (CGFloat)heighForText:(NSString *)string;


//返回长度
+(CGFloat)weightForText:(NSString *)str;

//修改图片尺寸 同比缩放
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

//标签的富文本
+(NSMutableAttributedString *)setBiaoqian:(NSString *)labelNameStr;

//提示框四秒
+(void)fm_showHudText:(NSString *)msg;

/// 显示菊花 【显示期间不能交互】
+(void)fm_showHudLoadingIndicator;
/// 隐藏菊花
+(void)fm_hidenHudIndicator;
/// 拨打电话
+(void)fm_callPhoneNumber:(NSString *)phoneNumber;
/// 删除某个控制器
+ (void)fm_theNavigationController:(UIViewController *)vc removeTheUIViewController:(NSString *)removeVcStr;
/// 格式化 CBD 和 积分 eg: 10CBD+2积分
+ (NSString *)fm_formatLineOne:(BOOL)lineOne coin:(NSInteger)coin point:(NSInteger)point ;
/// 格式化 CBD 和 ¥ eg: ¥2000+10CBD
+ (NSString *)fm_formatLineOne:(BOOL)lineOne formatCoin:(NSInteger)coin formatPoint:(NSInteger)point;
/// 复制字符
+ (void)fm_copyTextFormView:(id)objcView;
/// 判断输入框为空时提示文字
+ (BOOL)fm_notEmptyInputObjcView:(id)objcView  tip:(NSString *)tip;
@end
