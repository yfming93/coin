//
//  MJRefresh+FooterManger.m
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

// MJRefresh+FooterManger.m
#import "MJRefresh+FooterManger.h"
#import <ReactiveCocoa.h>
#define NO_MORE_DATA_TEXT @"没有更多数据了！"

@implementation UIScrollView (MJAutoRefreshFooterManger)

static char stateKey;
- (void)setFootRefreshState:(MJFooterRefreshState)footRefreshState {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [RACObserve(self.mj_footer, frame)subscribeNext:^(id x) {  //这里的意思是监视mj_footer的frame变化，可以使用kvo代替RACObserve
        CGPoint point = [self convertPoint:self.mj_footer.frame.origin toView:window];
        if (point.y < window.frame.size.height) {
            [(MJRefreshAutoNormalFooter *)self.mj_footer setTitle:@""forState:MJRefreshStateNoMoreData];
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
    [self handleFooterRefresh:footRefreshState];
    NSString *value = [NSString stringWithFormat:@"%ld", (long)footRefreshState];
    objc_setAssociatedObject(self, &stateKey, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (MJFooterRefreshState)footRefreshState {
    NSString *refreshState =objc_getAssociatedObject(self, &stateKey);
    if ([refreshState isEqualToString:@"MJFooterRefreshStateLoadMore"]) {
        return MJFooterRefreshStateNoMore;
    }
    else {
        return MJFooterRefreshStateLoadMore;
    }
}

- (void) handleFooterRefresh: (MJFooterRefreshState)footRefreshState {
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter*)self.mj_footer;
    switch (footRefreshState) {
        case MJFooterRefreshStateNormal: {
            [footer setTitle:@""forState:MJRefreshStateIdle];
            break;
        }
        case MJFooterRefreshStateLoadMore: {
            [self.mj_footer endRefreshing];
            break;
        }
        case MJFooterRefreshStateNoMore: {
            [footer setTitle:NO_MORE_DATA_TEXT forState:MJRefreshStateNoMoreData];
            [self.mj_footer endRefreshingWithNoMoreData];
            break;
        }
        default:
            break;
    }
}

@end
