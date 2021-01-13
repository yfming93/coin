//
//  FMBaseNavigationController.m
//  Taidi
//
//  Created by 扆佳梁 on 2017/4/7.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "FMBaseNavigationController.h"
#import <FMCategoryKit/UIImage+FMExtension.h>

@interface FMBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation FMBaseNavigationController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof(self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }

    //去除navigationBar下面的黑线
    //    self.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    // 设置导航栏背景
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColor.whiteColor;
   
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20.0f];
    self.navigationBar.titleTextAttributes = textAttrs;
    self.navigationBar.translucent = NO; //毛玻璃效果
    [((FMBaseKitNavigationController *)self) hideNavBottomLine];

//    self.navigationBar.shadowImage = UIImage.new;
    //    [appearance setTitleVerticalPositionAdjustment:-14 forBarMetrics:UIBarMetricsDefault];
    //    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    //    [barItem setBackgroundVerticalPositionAdjustment:-14 forBarMetrics:UIBarMetricsDefault];
    
    
}

-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    // 设置导航栏背景
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = _textColor;
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20.0f];
    self.navigationBar.titleTextAttributes = textAttrs;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
#pragma mark -  通过拦截push方法来设置每个push进来的控制器的返回按钮
//导航控制器里面
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        NSString *name = @"back_white_nav";
        if (self.leftItemImageName.length) {
            name = self.leftItemImageName;
        }
        [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        //        [btn sizeToFit];
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        // 让按钮内部的所有内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置内边距，让按钮靠近屏幕边缘
        //        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)backPop {
    [self popViewControllerAnimated:YES];
}



#pragma mark - Private Method

+ (void)initialize {
    
}




@end
