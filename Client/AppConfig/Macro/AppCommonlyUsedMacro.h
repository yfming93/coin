//
//  AppCommonlyUsedMacro.h
//  Client
//
//  Created by mingo on 2018/10/9.
//  Copyright © 2018年 mingo. All rights reserved.
//

#ifndef AppCommonlyUsedMacro_h
#define AppCommonlyUsedMacro_h
//存储首页历史搜索
#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]
#define kUserInfo Setting.sharedInstance.userInfo
#define LIMT @(40)
#define kSelfNavigationItemTitle(title) self.navigationItem.title = title;
#define kGVUserDefaults [GVUserDefaults standardUserDefaults]

#define kstrMoney(kMoney) [NSString stringWithFormat:@"¥%@",kMoney.length ? kMoney :@"0.00"]

#define knotEmptyInputObjcView(objcView,ktips) if ([FMCoreTools fm_notEmptyInputObjcView:objcView tip:ktips])  return;

//#pragma mark - 一些固定颜色
#define kMainColor kHexColor(#714EF0)
#define kMainTitleColor kRGBAColor(76, 26, 0, 1)
#define kSubTitleColor kRGBAColor(154, 154, 154, 1)
#define kBgMainColor [UIColor colorWithRed:0.19 green:0.20 blue:0.25 alpha:1.00]
#define kBgSubColor [UIColor colorWithRed:0.25 green:0.27 blue:0.33 alpha:1.00]
#define kMainOrangeColor [UIColor colorWithRed:0.98 green:0.46 blue:0.15 alpha:1.00]
#define kGreyBgColor kRGBAColor(245, 245, 245, 1)
#define kCBDMainBgColor kRGBAColor(49, 51, 64, 1)
#define kCBDSubBgColor kRGBAColor(66, 69, 87, 1)
#define kNavTitleColor kWhiteColor
#define kNavSubtitleColor kWhiteColor

#define kMainColorA kHexColor(#300ABD)
#define kMainColorB kHexColor(#5E25C4)
#define kTabbarNorColor rgba(102, 102, 102, 1)
#define kTabbarSelectColor rgba(250, 100, 122, 1)
#define kBgMainColor [UIColor colorWithRed:0.19 green:0.20 blue:0.25 alpha:1.00]
#define kGreyBgColor kRGBAColor(245, 245, 245, 1)

#define kUpdateing \
[FMCoreTools fm_showHudText:@"升级中..."];\
return ;

#endif /* AppCommonlyUsedMacro_h */
