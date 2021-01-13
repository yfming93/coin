//
//  FMButton.m
//  Client
//
//  Created by mingo on 2019/3/26.
//  Copyright © 2019年 mingo. All rights reserved.
//
//  Blog：http://www.yfmingo.cn  Email：yfmingo@163.com


#import "FMButton.h"

@interface FMButton ()

@end

@implementation FMButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self fm_subInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self fm_subInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self fm_subInit];
}

- (void)fm_subInit {

}

- (void)fm_viewModelRacCommand:(RACCommand *)racCommand needLoading:(BOOL)needLoading userInteractionEnabled:(BOOL)enabled subscribeNext:(void (^)(id x))nextBlock {
    weakSelf(self)
    if (needLoading) {
        [weakSelf fm_startLoading];
    }
    if (enabled) {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    }
    // 发送网络请求
    RACSignal *signal = [racCommand execute:nil];
    [signal subscribeNext:^(id x) {
        [weakSelf fm_needLoading:needLoading userInteractionEnabled:enabled];
        if (nextBlock) {
            nextBlock(x);
        }
    } error:^(NSError *error) {
        [weakSelf fm_needLoading:needLoading userInteractionEnabled:enabled];
    } completed:^{
        [weakSelf fm_needLoading:needLoading userInteractionEnabled:enabled];
    }];
}

- (void)fm_viewModelRacCommand:(RACCommand *)racCommand needLoading:(BOOL)needLoading  userInteractionEnabled:(BOOL)enabled subscribeTargetBtn:(void (^)(FMButton  *fmbtn))btnBlock subscribeNext:(void (^)(id x))nextBlock {
    weakSelf(self)
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        if (needLoading) {
            [weakSelf fm_startLoading];
        }
        if (enabled) {
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
        }
        if (btnBlock) {
            btnBlock(button);
        }
        // 发送网络请求
        RACSignal *signal = [racCommand execute:nil];
        [signal subscribeNext:^(id x) {
            [weakSelf fm_needLoading:needLoading userInteractionEnabled:enabled];
            if (nextBlock) {
                nextBlock(x);
            }
            //                NSString *customURL = [NSString stringWithFormat:@"FMRouter://FMPush/TwoViewController?name=home&userId=%@&age=18",@"9999"];
            //                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:customURL] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
        } error:^(NSError *error) {
            [weakSelf fm_needLoading:needLoading userInteractionEnabled:enabled];
        } completed:^{
            [weakSelf fm_needLoading:needLoading userInteractionEnabled:enabled];
        }];
    }];
}

- (void)fm_needLoading:(BOOL)needLoading  userInteractionEnabled:(BOOL)enabled {
    if (needLoading) {
        [self  fm_stopLoading];
    }
    if (enabled) {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    }
}


@end
