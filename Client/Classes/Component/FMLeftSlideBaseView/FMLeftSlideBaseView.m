//
//  FMLeftSlideBaseView.m
//  Client
//
//  Created by mingo on 2019/7/16.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMLeftSlideBaseView.h"

#define kScreenW            [UIScreen mainScreen].bounds.size.width       //屏幕宽度
#define kScreenH            [UIScreen mainScreen].bounds.size.height      //屏幕高度

@interface FMLeftSlideBaseView ()
@property (nonatomic, strong) UIView *backOver;
@property (nonatomic, assign) CGRect selfRect;

@end
@implementation FMLeftSlideBaseView



- (instancetype)initWithTargetVc:(UIViewController *)targetVc widthScale:(CGFloat)widthScale menuBgColor:(UIColor *)menuBgColor {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(-kScreenW * 2, 0, kScreenW, kScreenH);
        self.selfRect = self.frame;
        self.userInteractionEnabled = YES;
        self.show = NO;
        self.targetVc = targetVc;
        
        self.back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW * (widthScale ? widthScale:0.6), kScreenH)];
        _back.backgroundColor = UIColor.whiteColor;
        if (menuBgColor) {
            _back.backgroundColor = menuBgColor;
        }
        _back.userInteractionEnabled = YES;
        [self addSubview:_back];
        
        self.backOver = [[UIView alloc] initWithFrame:CGRectMake(self.back.width, 0, kScreenW - self.back.width, self.back.height)];
        _backOver.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _backOver.userInteractionEnabled = YES;
        [self addSubview:_backOver];
        [_backOver addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTapAction)]];
    }
    return self;
}

- (void)addTapAction {
    self.show = NO;
}

-(void)setShow:(BOOL)show {
    _show = show;
    if (show) {
        [self fm_show];
    } else {
        [self fm_hiden];
    }
}

- (void)fm_show {
//    self.frame = CGRectMake(-kScreenW, 0, kScreenW, kScreenH);
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);

    } completion:^(BOOL finished) {
        self.backOver.hidden = NO;
//        self.alpha = 1.0;

    }];
}

- (void)fm_hiden {
    self.backOver.hidden = YES;
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = self.selfRect;
    } completion:^(BOOL finished) {
//        self.alpha = 0.0;
    }];
}



@end
