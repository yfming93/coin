//
//  AppCoreHeaders.h
//  Client
//
//  Created by mingo on 2019/10/25.
//  Copyright © 2019 fleeming. All rights reserved.
//

#ifndef AppCoreHeaders_h
#define AppCoreHeaders_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 组件化 pod
#import <FMCategoryKit/FMCategoryKitNSString.h>
#import <FMCategoryKit/FMCategoryKitUIView.h>
#import <FMCategoryKit/FMCategoryKitUIImage.h>
#import <FMCategoryKit/FMCategoryKitUIButton.h>
#import <FMCategoryKit/CALayer+FMForXib.h>
#import <FMCategoryKit/FMCategoryKitUIColor.h>
#import <FMCategoryKit/FMCategoryKitUILable.h>
#import <FMCategoryKit/FMCategoryKitUIViewController.h>
#import <FMBaseKit/FMBaseKit.h>
#import <FMListPlaceholder/FMListPlaceholder.h>
#import <FMNetworking/FMNetworking.h>
#import <FMMacroKit/FMMacroKit.h>
#import <FMComponentKit/FMComponentKit.h>
#import <FMCategoryKit/NSString+FMDate.h>
#import <FMCategoryKit/NSString+FMExtension.h>
#import <FMCategoryKit/NSMutableArray+FMAdd.h>
#import <FMCategoryKit/UIButton+FMImagePosition.h>
#import <FMCategoryKit/UIButton+FMExtension.h>
#import <FMCategoryKit/UIButton+FMForClickDelay.h>
#import <FMCategoryKit/UILabel+FMExtension.h>
#import <FMCategoryKit/FMCategoryKitCore.h>

/// 基础宏
#import "AppThirdProviderKeys.h"    /// 第三方服务keys
#import "NotiyNameAndHudShowTips.h" /// 通知宏 文字提示宏
#import "AppCommonlyUsedMacro.h" // App 业务常用宏
#import "GVUserDefaults+Setting.h"
#import "FMEnumHeader.h"

/// 第三方库
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "AFNetworking.h"
#import "IQKeyboardManager.h"       //键盘移动
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MJExtension.h"
//#import "JPFPSStatus.h"             //显示fps
#import "EasyShowView.h"            //限时提示框 HUD
//#import "UIView+DCPagerFrame.h"     //父子控制器 https://www.jianshu.com/p/9d80edfaf751
#import <ReactiveCocoa.h>
// base
#import "FMBaseHeaders.h"



#endif /* AppCoreHeaders_h */
