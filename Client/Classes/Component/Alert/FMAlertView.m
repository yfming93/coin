//
//  FMAlertView.m
//  Client
//
//  Created by mingo on 2019/7/31.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMAlertView.h"
#import <ZJAnimationPopView.h>

@interface FMAlertView ()
@property (nonatomic, strong) ZJAnimationPopView *popView;
@end
@implementation FMAlertView


- (void)fm_title:(NSString *)title tip:(NSString *)tip subtip:(NSString *)subtip cancelBlock:(void(^)(id objc ))cancelBlock sureBlock:(void(^)(id objc))sureBlock {
    if (_tick_w.constant > 0) {
        [_tick setImage:FM_IMAGE(@"transaction_activation") forState:UIControlStateSelected];
        [_sure setTitleColor:kGreyColor forState:0];
        _sure.userInteractionEnabled = NO;
        [[_tick rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _tick.selected = !_tick.selected;
            if (_tick.selected) {
                [_sure setTitleColor:kMainColorA forState:0];
                _sure.userInteractionEnabled = YES;
            }else{
                [_sure setTitleColor:kGreyColor forState:0];
                _sure.userInteractionEnabled = NO;
            }
            
        }];
    }
   
    _title.text = title.length ? title : @"" ;
    _tips.text = tip.length ? tip : @"" ;
    _subtips.text = subtip.length ? subtip : @"" ;

    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:self popStyle:ZJAnimationPopStyleShakeFromTop dismissStyle:ZJAnimationDismissStyleCardDropToTop];
    self.popView = popView;
    [[_cancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (cancelBlock) {
            cancelBlock(x);
        }
        self.show = NO;
    }];
    
    [[_sure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (sureBlock) {
            sureBlock(x);
        }
        self.show = NO;
    }];
	
}

-(void)setShow:(BOOL)show {
    _show = show;
    if (show) {
        [self.popView pop];
    }else{
        [self.popView dismiss];
    }
}

@end
