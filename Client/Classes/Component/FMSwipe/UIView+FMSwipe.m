//
//  UIView+Swipe.m
//  Client
//
//  Created by mingo on 2019/12/12.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "UIView+FMSwipe.h"
#import "Masonry.h"

@interface FMSwipeButton ()

@property (nonatomic, copy) FMNoParameterBlock useForRecoverHandler;

@property (nonatomic, copy) FMNoParameterBlock clickHandler;

@end

@implementation FMSwipeButton

+ (instancetype)buttonWithTitle:(NSString *)title
                backgroundColor:(UIColor *)backgroundColor
                       callback:(FMNoParameterBlock)handler {
    
    return [self buttonWithTitle:title icon:nil backgroundColor:backgroundColor callback:handler];
}

+ (instancetype)buttonWithTitle:(NSString *)title
                           icon:(UIImage*)icon
                backgroundColor:(UIColor *)backgroundColor
                       callback:(FMNoParameterBlock)callback {
    
    FMSwipeButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateNormal];
    button.clickHandler = callback;
    [button sizeToFit];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (void)onClick:(FMSwipeButton *)sender {
    if (sender.clickHandler) {
        sender.clickHandler(nil);
    }
    if (sender.useForRecoverHandler) {
        sender.useForRecoverHandler(nil);
    }
}

@end

typedef NS_ENUM(NSInteger, ViewSwipePosition) {
    ViewSwipePositionNormal = 0,    // 正常位置
    ViewSwipePositionLeft = 1,      // 左侧按钮出现
    ViewSwipePositionRight = 2,     // 右侧按钮出现
};

@interface UIView ()

@property (nonatomic, weak) UIImageView *mainShotImageView;

@property (nonatomic, weak) UIView *leftView;

@property (nonatomic, weak) UIView *rightView;

@property (nonatomic, assign) ViewSwipePosition position;

@property (nonatomic, assign) CGFloat leftSwipeDistance;

@property (nonatomic, assign) CGFloat rightSwipeDistance;

@property (nonatomic, copy) FMNoParameterBlock leftSwipeHandler;

@property (nonatomic, copy) FMNoParameterBlock rightSwipeHandler;

@end

#define widthPerItem 78

NSString *const leftViewKey = @"leftViewKey";
NSString *const rightViewKey = @"rightViewKey";
NSString *const positionKey = @"positionKey";
NSString *const leftSwipeDistanceKey = @"leftSwipeDistanceKey";
NSString *const rightSwipeDistanceKey = @"rightSwipeDistanceKey";
NSString *const mainShotImageViewKey = @"mainShotImageViewKey";
NSString *const rightSwipeHandlerKey = @"rightSwipeHandlerKey";
NSString *const leftSwipeHandlerKey = @"leftSwipeHandlerKey";


@implementation UIView (FMSwipe)

- (void)setLeftView:(UIView *)leftView {
    objc_setAssociatedObject(self, &leftViewKey, leftView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)leftView {
    return objc_getAssociatedObject(self, &leftViewKey);
}

- (void)setRightView:(UIView *)rightView {
    objc_setAssociatedObject(self, &rightViewKey, rightView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)rightView {
    return objc_getAssociatedObject(self, &rightViewKey);
}

- (void)setMainShotImageView:(UIImageView *)mainShotImageView {
    objc_setAssociatedObject(self, &mainShotImageViewKey, mainShotImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)mainShotImageView {
    return objc_getAssociatedObject(self, &mainShotImageViewKey);
}

- (void)setPosition:(ViewSwipePosition)position {
    NSNumber *positionNum = [NSNumber numberWithInteger:position];
    objc_setAssociatedObject(self, &positionKey, positionNum, OBJC_ASSOCIATION_ASSIGN);
}

- (ViewSwipePosition)position {
    NSNumber *isRightNum = objc_getAssociatedObject(self, &positionKey);
    return isRightNum.integerValue;
}

- (void)setLeftSwipeDistance:(CGFloat)leftSwipeDistance {
    NSNumber *swipeDistanceNum = [NSNumber numberWithFloat:leftSwipeDistance];
    objc_setAssociatedObject(self, &leftSwipeDistanceKey , swipeDistanceNum, OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)leftSwipeDistance {
    NSNumber *swipeDistanceNum = objc_getAssociatedObject(self, &leftSwipeDistanceKey);
    return swipeDistanceNum.floatValue;
}

- (void)setRightSwipeDistance:(CGFloat)rightSwipeDistance {
    NSNumber *swipeDistanceNum = [NSNumber numberWithFloat:rightSwipeDistance];
    objc_setAssociatedObject(self, &rightSwipeDistanceKey, swipeDistanceNum, OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)rightSwipeDistance {
    NSNumber *swipeDistanceNum = objc_getAssociatedObject(self, &rightSwipeDistanceKey);
    return swipeDistanceNum.floatValue;
}

- (FMNoParameterBlock)leftSwipeHandler {
    FMNoParameterBlock block = objc_getAssociatedObject(self, &leftSwipeHandlerKey);
    return block;
}

- (void)setLeftSwipeHandler:(FMNoParameterBlock)leftSwipeHandler {
    objc_setAssociatedObject(self, &leftSwipeHandlerKey, leftSwipeHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FMNoParameterBlock)rightSwipeHandler {
    FMNoParameterBlock block = objc_getAssociatedObject(self, &rightSwipeHandlerKey);
    return block;
}

- (void)setRightSwipeHandler:(FMNoParameterBlock)rightSwipeHandler {
    objc_setAssociatedObject(self, &rightSwipeHandlerKey, rightSwipeHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configMainImageView {
    
    if (self.mainShotImageView) {
        return;
    }
    UIImageView *mainImageView = [[UIImageView alloc] init];
    mainImageView.hidden = YES;
    mainImageView.userInteractionEnabled = YES;
    [self addSubview:mainImageView];
    self.mainShotImageView = mainImageView;
    [mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(0);
    }];
}

- (void)fm_configLeftButtons:(NSArray<FMSwipeButton *> *)buttons
                    swipe:(FMNoParameterBlock)swipeHandler {
    
    if (buttons.count == 0) {
        return;
    }
    if (swipeHandler) {
        self.leftSwipeHandler = swipeHandler;
    }
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor whiteColor];
    [self addSubview:leftView];
    self.leftView = leftView;
    
    [self configMainImageView];
    
    self.leftSwipeDistance = widthPerItem * buttons.count;
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mainShotImageView.mas_left);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(0);
    }];
    
    [self configLeftSlipGesture];
    
    FMSwipeButton *currentBtn;
    __weak typeof(self)weakSelf = self;
    for (FMSwipeButton *btnItem in buttons) {
        [self.leftView addSubview:btnItem];
        [btnItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(currentBtn ? currentBtn.mas_left : self.leftView.mas_right);
            make.top.bottom.mas_equalTo(self.leftView);
            if (currentBtn) {
                make.width.mas_equalTo(currentBtn);
            }
        }];
        currentBtn = btnItem;
        currentBtn.useForRecoverHandler = ^(id x) {
            [weakSelf recoverSwipeState:UISwipeGestureRecognizerDirectionLeft];
        };
    }
    if (currentBtn) {
        [currentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftView);
        }];
    }
}

- (void)fm_configRightButtons:(NSArray<FMSwipeButton *> *)buttons
                     swipe:(FMNoParameterBlock)swipeHandler {
    
    if (buttons.count == 0) {
        return;
    }
    if (swipeHandler) {
        self.rightSwipeHandler = swipeHandler;
    }
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightView];
    self.rightView = rightView;
    
    [self configMainImageView];
    
    self.rightSwipeDistance = widthPerItem * buttons.count;
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainShotImageView.mas_right);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(0);
    }];
    
    [self configLeftSlipGesture];
    
    FMSwipeButton *currentBtn;
    __weak typeof(self)weakSelf = self;
    for (FMSwipeButton *btnItem in buttons) {
        [self.rightView addSubview:btnItem];
        [btnItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(currentBtn ? currentBtn.mas_right : self.rightView.mas_left);
            make.top.bottom.mas_equalTo(self.rightView);
            if (currentBtn) {
                make.width.mas_equalTo(currentBtn);
            }
        }];
        currentBtn = btnItem;
        currentBtn.useForRecoverHandler = ^(id x) {
            [weakSelf recoverSwipeState:UISwipeGestureRecognizerDirectionRight];
        };
    }
    if (currentBtn) {
        [currentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightView);
        }];
    }
}

- (void)fm_recover {
    
    if (self.position == ViewSwipePositionLeft) {
        [self recoverSwipeState:UISwipeGestureRecognizerDirectionLeft];
    } else if (self.position == ViewSwipePositionRight) {
        [self recoverSwipeState:UISwipeGestureRecognizerDirectionRight];
    }
}

- (void)recoverSwipeState:(UISwipeGestureRecognizerDirection)direction {
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] init];
    gesture.direction = direction;
    [self handleSwipeFrom:gesture];
}

- (void)configLeftSlipGesture {
    
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
    for (UIGestureRecognizer *gesture in self.mainShotImageView.gestureRecognizers) {
        [self.mainShotImageView removeGestureRecognizer:gesture];
    }
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:recognizerLeft];
    
    UISwipeGestureRecognizer *mainShotRecognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [mainShotRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.mainShotImageView addGestureRecognizer:mainShotRecognizerLeft];
    
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:recognizerRight];
    
    UISwipeGestureRecognizer *mainShotRecognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [mainShotRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.mainShotImageView addGestureRecognizer:mainShotRecognizerRight];
}



- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender {
    
    if (self.position == ViewSwipePositionNormal) {
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft && self.rightView) {
            self.mainShotImageView.image = [self screenShotView:self];
            self.mainShotImageView.hidden = NO;
            [self updateSelfPostionTo:ViewSwipePositionRight];
            if (self.rightSwipeHandler) {
                self.rightSwipeHandler(nil);
            }
        } else if (sender.direction == UISwipeGestureRecognizerDirectionRight && self.leftView) {
            self.mainShotImageView.image = [self screenShotView:self];
            self.mainShotImageView.hidden = NO;
            [self updateSelfPostionTo:ViewSwipePositionLeft];
            if (self.leftSwipeHandler) {
                self.leftSwipeHandler(nil);
            }
        }
    } else if (self.position == ViewSwipePositionLeft) {
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            [self updateSelfPostionTo:ViewSwipePositionNormal];
        }
    } else if (self.position == ViewSwipePositionRight) {
        if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            [self updateSelfPostionTo:ViewSwipePositionNormal];
        }
    }
}

- (void)updateSelfPostionTo:(ViewSwipePosition)position {
    
    CGFloat offset = 0;
    if (position == ViewSwipePositionRight) {
        offset = self.rightSwipeDistance;
    } else if (position == ViewSwipePositionLeft) {
        offset = -self.leftSwipeDistance;
    }
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    [self.mainShotImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-offset);
        make.right.mas_equalTo(self.mas_right).offset(-offset);
    }];
    
    if (position == ViewSwipePositionLeft) {
        [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(-offset);
        }];
    } else if (position == ViewSwipePositionRight) {
        [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(offset);
        }];
    }
    
    self.position = position;
    
    if (self.position == ViewSwipePositionNormal) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.mainShotImageView.hidden = YES;
        });
    }
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

// 对指定视图进行截图
- (UIImage *)screenShotView:(UIView *)view {
    
    UIImage *imageRet = nil;
    if (view) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
        //获取图像
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        imageRet = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    } else {
        
    }
    return imageRet;
}

@end
