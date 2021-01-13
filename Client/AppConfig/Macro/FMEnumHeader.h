//
//  FMEnumHeader.h
//  Client
//
//  Created by mingo on 2019/4/1.
//  Copyright © 2019年 mingo. All rights reserved.
//

#ifndef FMEnumHeader_h
#define FMEnumHeader_h
typedef NS_ENUM(NSInteger, PayType) {
    /// 立即购买
    PayTypeshoppingCartId = 1,
    /// 结算购物车
    PayTypeShopCarAll = 2,
    /// 未付款
    PayTypeOrderId = 3,
};


#endif /* FMEnumHeader_h */
