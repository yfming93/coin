//
//  UIView+Swipe.h
//  Client
//
//  Created by mingo on 2019/12/12.
//  Copyright © 2019 fleeming. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^FMNoParameterBlock)(id x);
@interface FMSwipeButton : UIButton

+ (instancetype)buttonWithTitle:(NSString *)title
                backgroundColor:(UIColor *)backgroundColor
                       callback:(FMNoParameterBlock)handler;

@end

@interface UIView (FMSwipe)

/** 配置左侧的按钮 */
- (void)fm_configLeftButtons:(NSArray<FMSwipeButton *> *)buttons swipe:(FMNoParameterBlock)swipeHandler;
/** 配置右侧的按钮 */
- (void)fm_configRightButtons:(NSArray<FMSwipeButton *> *)buttons swipe:(FMNoParameterBlock)swipeHandler;
/** 从侧滑状态复位 */
- (void)fm_recover;

@end
