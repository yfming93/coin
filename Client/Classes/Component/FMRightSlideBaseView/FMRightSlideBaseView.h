//
//  FMRightSlideBaseView.h
//  Client
//
//  Created by mingo on 2019/7/29.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMRightSlideBaseView : UIView
- (instancetype)initWithTargetVc:(UIViewController *)targetVc widthScale:(CGFloat)widthScale menuBgColor:(UIColor *)menuBgColor;
/** <#注释#>*/
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) UIView *back;
@property (nonatomic, strong) UIViewController *targetVc;


@end

NS_ASSUME_NONNULL_END
