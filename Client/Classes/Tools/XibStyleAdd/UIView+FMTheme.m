//
//  UIView+FMTheme.m
//  HJViewStyle_Example
//
//  Created by JohnnyHoo on 2018/12/20.
//  Copyright © 2018 Johnny. All rights reserved.
//

#import "UIView+FMTheme.h"

@implementation UIView (FMTheme)


/*
 因为很多APP都会有主题颜色,为了更方便的设置主题色可以重写下面的方法
 themeGradientEnable = YES 的时候将启用下面配色
 */

- (UIColor *)themeGradientAColor
{
    return kMainColorA;
}

- (UIColor *)themeGradientBColor
{
    return kMainColorB;
}

- (NSInteger)themeGradientStyle
{
    return 1;//1,//渐变左到右 GradientStyleTopToBottom = 2//渐变上到下
}


@end
