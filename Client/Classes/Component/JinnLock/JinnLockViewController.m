/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockViewController.m
 **  Description: 解锁密码控制器
 **
 **  Author:  jinnchang
 **  Date:    2016/9/22
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "JinnLockViewController.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "Masonry.h"
#import "JinnLockConfig.h"

typedef NS_ENUM(NSInteger, JinnLockStep)
{
    JinnLockStepNone = 0,
    JinnLockStepCreateNew,
    JinnLockStepCreateAgain,
    JinnLockStepCreateNotMatch,
    JinnLockStepCreateReNew,
    JinnLockStepModifyOld,
    JinnLockStepModifyOldError,
    JinnLockStepModifyReOld,
    JinnLockStepModifyNew,
    JinnLockStepModifyAgain,
    JinnLockStepModifyNotMatch,
    JinnLockStepModifyReNew,
    JinnLockStepVerifyOld,
    JinnLockStepVerifyOldError,
    JinnLockStepVerifyReOld,
    JinnLockStepRemoveOld,
    JinnLockStepRemoveOldError,
    JinnLockStepRemoveReOld
};

@interface JinnLockViewController () <JinnLockSudokoDelegate>

@property (nonatomic, weak) id<JinnLockViewControllerDelegate> delegate;
@property (nonatomic, assign) JinnLockType       type;
@property (nonatomic, assign) JinnLockAppearMode appearMode;

@property (nonatomic, strong) JinnLockIndicator  *indicator;
@property (nonatomic, strong) JinnLockSudoko     *sudoko;
@property (nonatomic, strong) UILabel            *noticeLabel;
@property (nonatomic, strong) UIButton           *resetButton;
@property (nonatomic, strong) UIButton           *touchIdButton;

@property (nonatomic, assign) JinnLockStep       step;
@property (nonatomic, strong) NSString           *passcodeTemp;
@property (nonatomic, strong) LAContext          *context;
@property (nonatomic, copy) LockVerifyResultBlock verifyResultBlock;

@end

@implementation JinnLockViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self createViews];
    
    switch (self.type)
    {
        case JinnLockTypeCreate:
        {
            [self updateUiForStep:JinnLockStepCreateNew];
        }
            break;
        case JinnLockTypeModify:
        {
            [self updateUiForStep:JinnLockStepModifyOld];
        }
            break;
        case JinnLockTypeVerify:
        {
            [self updateUiForStep:JinnLockStepVerifyOld];
            
            if ([JinnLockTool isTouchIdUnlockEnabled] && [JinnLockTool isTouchIdSupported])
            {
                [self showTouchIdView];
            }
        }
            break;
        case JinnLockTypeRemove:
        {
            [self updateUiForStep:JinnLockStepRemoveOld];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Init

- (instancetype)initWithDelegate:(id<JinnLockViewControllerDelegate>)delegate
                            type:(JinnLockType)type
                      appearMode:(JinnLockAppearMode)appearMode verifyResultBlock:(LockVerifyResultBlock)verifyResultBlock
{
    self = [super init];
    
    if (self)
    {
        self.delegate   = delegate;
        self.type       = type;
        self.appearMode = appearMode;
        self.verifyResultBlock = verifyResultBlock;
    }
    
    return self;
}

- (void)setup
{
    self.view.backgroundColor = JINN_LOCK_COLOR_BACKGROUND;
    self.step = JinnLockStepNone;
    self.context = [[LAContext alloc] init];
}

- (void)createViews
{
    JinnLockSudoko *sudoko = [[JinnLockSudoko alloc] init];
    [sudoko setDelegate:self];
    [self.view addSubview:sudoko];
    [self setSudoko:sudoko];
    [sudoko mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kSudokoSideLength, kSudokoSideLength));
    }];
    
    JinnLockIndicator *indicator = [[JinnLockIndicator alloc] init];
    [self.view addSubview:indicator];
    [self setIndicator:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(sudoko.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kIndicatorSideLength, kIndicatorSideLength));
    }];
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    [noticeLabel setFont:[UIFont systemFontOfSize:14]];
    [noticeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noticeLabel];
    [self setNoticeLabel:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(indicator.mas_top).offset(-30);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton setTitle:kJinnLockResetText forState:UIControlStateNormal];
    [resetButton setTitleColor:JINN_LOCK_COLOR_BUTTON forState:UIControlStateNormal];
    [resetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    [self setResetButton:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(sudoko.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *touchIdButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [touchIdButton setTitle:kJinnLockTouchIdText forState:UIControlStateNormal];
    [touchIdButton setTitleColor:JINN_LOCK_COLOR_BUTTON forState:UIControlStateNormal];
    [touchIdButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [touchIdButton addTarget:self action:@selector(touchIdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touchIdButton];
    [self setTouchIdButton:touchIdButton];
    [touchIdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(sudoko.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    if ([JinnLockTool isTouchIdUnlockEnabled]) {
        if (![JinnLockTool isGestureUnlockEnabled]) {
            UIButton *touchBtn = [[UIButton alloc] init];
            [touchBtn setBackgroundImage:[UIImage imageNamed:@"touch_id"] forState:0];
            [touchBtn addTarget:self action:@selector(touchIdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:touchBtn];
            [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
        }
    }
    
}

#pragma mark - Private

- (void)showTouchIdView
{
    [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                 localizedReason:@"通过验证指纹解锁"
                           reply:^(BOOL success, NSError * _Nullable error) {
                               if (success)
                               {
                                   if (self.verifyResultBlock) {
                                       self.verifyResultBlock(nil,JinnLockVerifyResultTypeTouchIdSuccess);
                                   }
                                   [self hide];
                               }else if (error.code == LAErrorUserCancel){
                                   if (self.verifyResultBlock) {
                                       self.verifyResultBlock(self,JinnLockVerifyResultTypeTouchIdCancel);
                                   }
                               }else{
                                   if (self.verifyResultBlock) {
                                       self.verifyResultBlock(nil,JinnLockVerifyResultTypeTouchIdFailure);
                                   }
                                   // 错误码 error.code
                                   switch (error.code) {
                                           
//                                       case LAErrorUserCancel: { NSLog(@"用户取消验证Touch ID");
//                                           // -2 在TouchID对话框中点击了取消按钮或者按了home键
//                                       }
//                                           break;
                                           
                                       case LAErrorUserFallback: {
                                           
                                           NSLog(@"用户选择输入密码"); // -3 在TouchID对话框中点击了输入密码按钮
                                       }
                                           break;
                                           
                                       case LAErrorSystemCancel: { NSLog(@"取消授权，如其他应用切入，用户自主"); // -4 TouchID对话框被系统取消，例如按下电源键
                                       }
                                           break;
                                           
                                       case LAErrorPasscodeNotSet: {
                                           NSLog(@"设备系统未设置密码"); // -5
                                       }
                                           break;
                                           
                                       case LAErrorTouchIDNotAvailable: {
                                           
                                           NSLog(@"设备未设置Touch ID"); // -6
                                       }
                                           break;
                                           
                                       case LAErrorTouchIDNotEnrolled:  {
                                           
                                           NSLog(@"用户未录入指纹"); // -7
                                       }
                                           break;
                                           
                                       case LAErrorAppCancel: {
                                           NSLog(@"用户不能控制情况下APP被挂起"); // -9
                                       }
                                           break;
                                           
                                       case LAErrorInvalidContext: {
                                           
                                           NSLog(@"LAContext传递给这个调用之前已经失效"); // -10
                                       }
                                           break;
                                           
                                       default: {
                                           NSLog(@"其他情况");
                                       }
                                           break;
                                   }
                               }
                              
                           }];
}

- (void)updateUiForStep:(JinnLockStep)step
{
    self.step = step;
    
    switch (step)
    {
        case JinnLockStepCreateNew:
        {
            self.noticeLabel.text = kJinnLockNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateAgain:
        {
            self.noticeLabel.text = kJinnLockAgainText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = NO;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateNotMatch:
        {
            self.noticeLabel.text = kJinnLockNotMatchText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateReNew:
        {
            self.noticeLabel.text = kJinnLockReNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOld:
        {
            self.noticeLabel.text = kJinnLockOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOldError:
        {
            self.noticeLabel.text = kJinnLockOldErrorText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReOld:
        {
            self.noticeLabel.text = kJinnLockReOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyNew:
        {
            self.noticeLabel.text = kJinnLockNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyAgain:
        {
            self.noticeLabel.text = kJinnLockAgainText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = NO;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyNotMatch:
        {
            self.noticeLabel.text = kJinnLockNotMatchText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReNew:
        {
            self.noticeLabel.text = kJinnLockReNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyOld:
        {
            self.noticeLabel.text = kJinnLockVerifyText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            
            if ([JinnLockTool isTouchIdUnlockEnabled] && [JinnLockTool isTouchIdSupported])
            {
                self.touchIdButton.hidden = NO;
            }
            else
            {
                self.touchIdButton.hidden = YES;
            }
        }
            break;
        case JinnLockStepVerifyOldError:
        {
            self.noticeLabel.text = kJinnLockOldErrorText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyReOld:
        {
            self.noticeLabel.text = kJinnLockReVerifyText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            
            if ([JinnLockTool isTouchIdUnlockEnabled] && [JinnLockTool isTouchIdSupported])
            {
                self.touchIdButton.hidden = NO;
            }
            else
            {
                self.touchIdButton.hidden = YES;
            }
        }
            break;
        case JinnLockStepRemoveOld:
        {
            self.noticeLabel.text = kJinnLockOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOldError:
        {
            self.noticeLabel.text = kJinnLockOldErrorText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveReOld:
        {
            self.noticeLabel.text = kJinnLockReOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
        default:
            break;
    }
}

- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - Action

- (void)hide
{
    if (self.appearMode == JinnLockAppearModePush)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.appearMode == JinnLockAppearModePresent)
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)resetButtonClicked
{
    if (self.type == JinnLockTypeCreate)
    {
        [self updateUiForStep:JinnLockStepCreateNew];
    }
    else if (self.type == JinnLockTypeModify)
    {
        [self updateUiForStep:JinnLockStepModifyNew];
    }
}

- (void)touchIdButtonClicked
{
    [self showTouchIdView];
}

#pragma mark - JinnLockSudokoDelegate

- (void)sudoko:(JinnLockSudoko *)sudoko passcodeDidCreate:(NSString *)passcode
{
    if ([passcode length] < kConnectionMinNum)
    {
        [self.noticeLabel setText:JINN_LOCK_NOT_ENOUGH];
        [self.noticeLabel setTextColor:JINN_LOCK_COLOR_ERROR];
        [self shakeAnimationForView:self.noticeLabel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateUiForStep:self.step];
        });
        
        return;
    }
    
    switch (self.step)
    {
        case JinnLockStepCreateNew:
        case JinnLockStepCreateReNew:
        {
            self.passcodeTemp = passcode;
            [self updateUiForStep:JinnLockStepCreateAgain];
        }
            break;
        case JinnLockStepCreateAgain:
        {
            if ([passcode isEqualToString:self.passcodeTemp])
            {
                [JinnLockTool setGestureUnlockEnabled:YES];
                [JinnLockTool setGesturePasscode:passcode];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidCreate:)])
                {
                    [self.delegate passcodeDidCreate:passcode];
                }
                
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepCreateNotMatch];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepCreateReNew];
                });
            }
        }
            break;
        case JinnLockStepModifyOld:
        case JinnLockStepModifyReOld:
        {
            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            {
                [self updateUiForStep:JinnLockStepModifyNew];
            }
            else
            {
                [self updateUiForStep:JinnLockStepModifyOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepModifyReOld];
                });
            }
        }
            break;
        case JinnLockStepModifyNew:
        case JinnLockStepModifyReNew:
        {
            self.passcodeTemp = passcode;
            [self updateUiForStep:JinnLockStepModifyAgain];
        }
            break;
        case JinnLockStepModifyAgain:
        {
            if ([passcode isEqualToString:self.passcodeTemp])
            {
                [JinnLockTool setGestureUnlockEnabled:YES];
                [JinnLockTool setGesturePasscode:passcode];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidModify:)])
                {
                    [self.delegate passcodeDidModify:passcode];
                }
                
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepModifyNotMatch];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepModifyReNew];
                });
            }
        }
            break;
        case JinnLockStepVerifyOld:
        case JinnLockStepVerifyReOld:
        {
            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            {
                if ([self.delegate respondsToSelector:@selector(passcodeDidVerify:)])
                {
                    [self.delegate passcodeDidVerify:passcode];
                }
                
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepVerifyOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepVerifyReOld];
                });
            }
        }
            break;
        case JinnLockStepRemoveOld:
        case JinnLockStepRemoveReOld:
        {
            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            {
                [JinnLockTool setGestureUnlockEnabled:NO];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidRemove)])
                {
                    [self.delegate passcodeDidRemove];
                }
                
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepRemoveOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepRemoveReOld];
                });
            }
        }
            break;
        default:
            break;
    }
    
    [self.indicator showPasscode:passcode];
}

@end
