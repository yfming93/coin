//
//  FMAlertSheetView.m
//  Client
//
//  Created by mingo on 2019/8/2.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMAlertSheetView.h"
#import <ZJAnimationPopView.h>
#define klineColor [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]
#define kItem_h 44
@interface FMAlertSheetView ()
@property (nonatomic, strong) ZJAnimationPopView *popView;
@property (nonatomic, strong) NSMutableArray <NSString *>*titles;
@property(nonatomic, assign) BOOL needCancel;
@property(nonatomic, strong) UIButton *selectBtn;

@end

@implementation FMAlertSheetView

- (instancetype)initWithTitles:(NSMutableArray *)titles atIndex:(NSInteger)atIndex needCancel:(BOOL)needCancel  handlerBlock:(void(^)(id objc, NSInteger index))handlerBlock {
    self = [super init];
    if (self) {
        self.backgroundColor = klineColor;
        self.titles = titles;
        self.needCancel = needCancel;
        kViewRadius(self, 5);
        if (needCancel) {
            [self.titles addObject:@"取消"];
        }
        CGFloat reth = titles.count * kItem_h + 15 ;
        self.frame = CGRectMake(0, 0, kScreenW, reth);
//        [self fm_layoutSubviews];
        
        for (NSInteger i = 0; i < self.titles.count; i++) {
            NSString *str = self.titles[i];
            UIButton *btn = [UIButton fm_initButtonNormalTitleColor:kHexColor(0x85929E) backgroundColor:kWhiteColor font:15 normalImage:nil cornerRadius:0 addToSuperView:self normalTitle:str];
            [btn setTitleColor:kMBBlueColor forState:UIControlStateSelected];
            CGFloat gaph = 0;
            if (self.needCancel && (i == (self.titles.count - 1))) {
                gaph = 10;
            }
            btn.frame = CGRectMake(0, i * kItem_h + gaph, self.frame.size.width, kItem_h);
            btn.tag = i;
            if (i == atIndex) {
                btn.selected = YES;
                self.selectBtn = btn;
            }
            
            if ((i != (self.titles.count - 1))) {
                UIView *line = UIView.alloc.init;
                line.backgroundColor = klineColor;
                [btn addSubview:line];
                line.frame = CGRectMake(btn.x, btn.height - 1, btn.width, 1);
            }
            
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                self.selectBtn.selected =  !self.selectBtn.selected;
                btn.selected = YES;
                self.selectBtn = btn;
                
                if (btn.tag == self.titles.count - 1) {
                    
                }else{
                    if (handlerBlock) {
                        handlerBlock(str,btn.tag);
                    }
                }
                
               
                self.show = NO;
            }];

        }
        
        
        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:self popStyle:ZJAnimationPopStyleShakeFromBottom dismissStyle:ZJAnimationDismissStyleDropToBottom];
        self.bottom = popView.bottom + 5;
        self.popView = popView;
        
    }
    return self;
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
