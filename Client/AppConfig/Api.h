//
//  Api.h
//  Client
//
//  Created by mingo on 2018/10/7.
//  Copyright © 2018年 mingo. All rights reserved.



#ifndef Api_h
#define Api_h

#define kHostUrl    [NSString stringWithFormat:@"%@",FMAssistiveTouchManager.shareInstance.kMainHost] /// 币币正式
#define kSubHostText @"/"
#define kHostV2(parameter) [NSString stringWithFormat:@"%@%@%@",kHostUrl,kSubHostText,parameter]

#pragma mark - 基础服务

/// 版本更新
#define kurl_cms_api_appversion_newAppVersion @"cms/api/appversion/newAppVersion?appType=ios&tenantCode=1"


#pragma mark - 个人中心

///////////////////// 大重构

#pragma mark - 个人中心
/// 商品收藏列表
#define kurl_ums_api_member_collection_list @"ums/api/member/collection/list"
/// 添加商品收藏
#define kurl_ums_api_member_collection_add @"ums/api/member/collection/add"
/// 取消收藏
#define kurl_ums_api_member_collection_deleteByIds @"ums/api/member/collection/deleteByIds"

/// 我的足迹列表
#define kurl_ums_api_member_history_list @"ums/api/member/history/list"
/// 清空我的足迹
#define kurl_ums_api_member_history_deleteByIds @"ums/api/member/history/deleteByIds"


/// 会员用户中心信息
#define kurl_ums_api_member_getUserInfo @"ums/api/member/getUserInfo"
/// 通用获取短信验证码POST请求Jason传参
#define kurl_ums_api_sms_getCheckCode @"ums/api/sms/getCheckCode"
/// 更新个人信息
#define kurl_ums_api_member_update @"ums/api/member/update"
/// 修改支付密码
#define kurl_ums_api_member_setPayPassword @"ums/api/member/setPayPassword"


#pragma mark - 我的服务
/// 钱包明细
#define kurl_awardFlow_list              @"awardFlow/list"
/// 升级会员
#define kurl_sso_updateToVip             @"sso/updateToVip"
/// 奖金明细
#define kurl_awardFlow_list              @"awardFlow/list"
/// 奖金提现
#define kurl_wallet_withdrawMoney        @"wallet/withdrawMoney"
/// 提现流水
#define kurl_wallet_withdrawList         @"wallet/withdrawList"
/// 我的分享等级
#define kurl_sso_getUmsMemberOneLevel_id @"sso/getUmsMemberLevel"
/// 地推助手
#define kurl_sso_getShareCode            @"sso/getShareCode"
///  提现列表
#define kurl_payment_list                @"payment/list"
/// 新增提现方式
#define kurl_payment_addPayment          @"payment/addPayment"

#endif /* Api_h */


