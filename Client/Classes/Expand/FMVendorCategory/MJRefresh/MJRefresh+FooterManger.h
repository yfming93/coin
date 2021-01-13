//
//  MJRefresh+FooterManger.h
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//


// MJRefresh+FooterManger.h
#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, MJFooterRefreshState) {
    MJFooterRefreshStateNormal,
    MJFooterRefreshStateLoadMore,
    MJFooterRefreshStateNoMore
};

@interface UIScrollView (MJRefreshAutoManger)
@property (nonatomic,assign)MJFooterRefreshState footRefreshState;

@end
