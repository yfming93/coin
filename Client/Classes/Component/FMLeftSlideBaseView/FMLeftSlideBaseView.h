//
//  FMLeftSlideBaseView.h
//  Client
//
//  Created by mingo on 2019/7/16.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMLeftSlideBaseView : UIView
- (instancetype)initWithTargetVc:(UIViewController *)targetVc widthScale:(CGFloat)widthScale menuBgColor:(UIColor *)menuBgColor;
/** <#注释#>*/
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) UIView *back;
@property (nonatomic, strong) UIViewController *targetVc;


@end

