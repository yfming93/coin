//
//  Tools.m
//  PovertyAlleviation_OC
//
//  Created by TongHu on 2017/11/30.
//  Copyright © 2017年 tonghu. All rights reserved.
//

#import "FMCoreTools.h"

@implementation FMCoreTools

+(NSString *)interceptTimeStampFromStr:(NSString *)str{
    if (!str || [str length] == 0 ) {  // 字符串为空判断
        return @"";
    }
    // 把时间戳转化成时间
    NSTimeInterval interval=[str integerValue] / 1000 ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

+ (NSString *)interceptTwoTimeStampFromStr:(NSString *)str{
    if (!str || [str length] == 0 ) {  // 字符串为空判断
        return @"";
    }
    // 把时间戳转化成时间
    NSTimeInterval interval=[str integerValue] / 1000 ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

+ (NSString *)interceptThreeTimeStampFromStr:(NSString *)str{
    if (!str || [str length] == 0 ) {  // 字符串为空判断
        return @"";
    }
    // 把时间戳转化成时间
    NSTimeInterval interval=[str integerValue] / 1000 ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

+ (NSString *)interceptFourTimeStampFromStr:(NSString *)str{
    if (!str || [str length] == 0 ) {  // 字符串为空判断
        return @"";
    }
    // 把时间戳转化成时间
    NSTimeInterval interval=[str integerValue] / 1000 ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSDate *)aDate {
    //当前时间
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    NSInteger aa = 0;
//    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
//    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *dta = [[NSDate alloc] init];
    //传入时间
//    dta = [dateformater dateFromString:aDate];
    NSComparisonResult result = [date compare:aDate];
    if (result == NSOrderedSame) {
        //相等
        aa= 0;
    }else if (result == NSOrderedAscending) {
        //传入时间 大
        aa= -1;
    }else if (result == NSOrderedDescending)  {
        //当前时间 大
        aa= 1;
    }
    return aa;
}

+(NSString *)makeTime{
    /**
     获取当前时间
     - returns: 返回时间
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

+(NSString *)makeYear{
    /**
     获取当前时间
     - returns: 返回时间
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

+(NSString *)makeYearMonth{
    /**
     获取当前时间
     - returns: 返回时间
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

+(NSString *)makeYearMonthDayhms{
    /**
     获取当前时间
     - returns: 返回时间
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

+(NSString *)makeMonth{
    /**
     获取当前时间
     - returns: 返回时间
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

+ (NSDate *)getCurrentTime{
    
    //2017-04-24 08:57:29
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    //保存当前时间后14分钟
    NSTimeInterval interval = 60 * 14;
    NSDate *date2 = [NSDate dateWithTimeInterval:interval sinceDate:date];
    return date2;
}

+ (CGFloat)heighForText:(NSString *)string{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange allRange = [string rangeOfString:string];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:allRange];
//    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor]range:allRange];
    CGFloat titleHeight;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //获取label的最大宽度
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(kScreenW - 30, CGFLOAT_MAX)options:options context:nil];
    titleHeight = ceilf(rect.size.height);
    return titleHeight;
    
}

+(CGFloat)weightForText:(NSString *)str{
    CGSize textSize1 = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    return textSize1.width;
}

//修改图片尺寸 同比缩放
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize {
    
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    } else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

+(NSMutableAttributedString *)setBiaoqian:(NSString *)labelNameStr{
    // 创建一个富文本  前后加空格
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@  ",labelNameStr]];
    
    // 修改富文本中的不同文字的样式
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(3, labelNameStr.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, labelNameStr.length)];
    // 设置数字
    
    // 创建一个放置图片的富文本
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"3941_hd"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 12, 12);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:2];
    return attri;
}

+(void)fm_showHudText:(NSString *)msg{
    [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowTextStatusTypeMidden;
    [EasyShowOptions sharedEasyShowOptions].textBackGroundColor = UIColor.blackColor;
    [EasyShowTextView showText:msg];
}

+(void)fm_showHudLoadingIndicator{
    [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowTextStatusTypeMidden;
    [EasyShowOptions sharedEasyShowOptions].lodingSuperViewReceiveEvent = NO;
    [EasyShowOptions sharedEasyShowOptions].lodingShowOnWindow = YES;
    [EasyShowOptions sharedEasyShowOptions].lodingAnimationType = lodingAnimationTypeBounce;
    [EasyShowOptions sharedEasyShowOptions].lodingShowType = LodingShowTypeIndicator;
    [EasyShowLodingView showLodingText:@""];
}

+(void)fm_hidenHudIndicator {
    [EasyShowLodingView hidenLoding];
}

+(void)fm_callPhoneNumber:(NSString *)phoneNumber {
    NSString *str = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *telStr = [NSString stringWithFormat:@"tel:%@",str];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:telStr]]){
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
    }else{
        // 拨打失败
        [FMCoreTools fm_showHudText:@"无法拨打该电话"];
    }
}

+ (void)fm_theNavigationController:(UIViewController *)vc removeTheUIViewController:(NSString *)removeVcStr{
    NSArray *arr = vc.navigationController.viewControllers;
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:arr];
    for(UIViewController *temVC in vc.navigationController.viewControllers) {
        if ([temVC isKindOfClass:NSClassFromString(removeVcStr)]) {
            [muArr removeObject:temVC];
        }
    }
    vc.navigationController.viewControllers = muArr;
}

+ (NSString *)fm_formatLineOne:(BOOL)lineOne coin:(NSInteger)coin point:(NSInteger)point {
    NSString *str = @"";
//    if (point>0) {
//        if (lineOne) {
//            str = [NSString stringWithFormat:@"¥%ld+%ldMBRX",coin,point];
//        }else{
//            str = [NSString stringWithFormat:@"¥%ld\n%ldMBRX",coin,point];
//        }
//    }else{
//        str = [NSString stringWithFormat:@"¥%ld",coin];
//    }
    str = [NSString stringWithFormat:@"¥%ld",coin];

    return str;
}

+ (NSString *)fm_formatLineOne:(BOOL)lineOne formatCoin:(NSInteger)coin formatPoint:(NSInteger)point {
    NSString *str = @"";
    if (point>0) {
        if (lineOne) {
            str = [NSString stringWithFormat:@"¥%ld+%ldMBRX",coin,point];
        }else{
            str = [NSString stringWithFormat:@"¥%ld\n%ldMBRX",coin,point];
        }
    }else{
        str = [NSString stringWithFormat:@"%ldMBRX",coin];
    }
    return str;
}

+ (void)fm_copyTextFormView:(id)objcView {
    NSString *copyStr = @"";
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if ([objcView isKindOfClass:UILabel.class] && ((UILabel *)(objcView)).text.length > 0) {
        copyStr = ((UILabel *)(objcView)).text;
    }
    if ([objcView isKindOfClass:UIButton.class] && ((UIButton *)(objcView)).titleLabel.text.length > 0) {
        copyStr = ((UIButton *)(objcView)).titleLabel.text;
    }
    if ([objcView isKindOfClass:UITextField.class] && ((UITextField *)(objcView)).text.length > 0) {
        copyStr = ((UITextField *)(objcView)).text;
    }
    if ([objcView isKindOfClass:UITextView.class] && ((UITextView *)(objcView)).text.length > 0) {
        copyStr = ((UITextView *)(objcView)).text;
    }
    if (copyStr.length) {
        pasteboard.string = copyStr;
        [FMCoreTools fm_showHudText:[NSString stringWithFormat:@"已复制:%@",copyStr]];
    }else{
        [FMCoreTools fm_showHudText:@"没内容哦"];
    }
}


+ (BOOL)fm_notEmptyInputObjcView:(id)objcView  tip:(NSString *)tip{
    BOOL isEmpty = NO;
    
    if ([objcView isKindOfClass:NSString.class] && ((NSString *)(objcView)).length <= 0) {
        isEmpty = YES;
    }
    if ([objcView isKindOfClass:UITextField.class] && ((UITextField *)(objcView)).text.length <= 0) {
        isEmpty = YES;
    }
    if ([objcView isKindOfClass:UITextView.class] && ((UITextView *)(objcView)).text.length <= 0) {
        isEmpty = YES;
    }
    if (isEmpty) {
        [FMCoreTools fm_showHudText:tip];
    }
    return isEmpty;
}

@end
