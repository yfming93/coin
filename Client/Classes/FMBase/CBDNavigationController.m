//
//  CBDCBDNavigationController.m
//  Taidi
//
//  Created by 扆佳梁 on 2017/4/7.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "CBDNavigationController.h"


@interface CBDNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CBDNavigationController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //    [self setValue:[[TDNavigationBar alloc] init] forKey:@"navigationBar"];
     // 设置导航栏背景
    [self.navigationBar setBackgroundImage: [UIImage imageWithColor:kCBDMainBgColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 禁止侧滑返回
    //    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    //    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    //    [self.view addGestureRecognizer:pan];
    
    __weak __typeof(self)weakSelf = self;
    // __block ERNavigationViewController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    //    [bar setTitleVerticalPositionAdjustment:-40 forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -  通过拦截push方法来设置每个push进来的控制器的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view并调用viewController的viewDidLoad方法。可以在viewDidLoad方法中重新设置自己想要的左上角按钮样式
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 1) { // 如果push进来的不是第一个控制器
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"top_return"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        //        [btn sizeToFit];
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        // 让按钮内部的所有内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //设置内边距，让按钮靠近屏幕边缘
        //        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
}

- (void)back {
    //    [self popViewControllerAnimated:YES];
    
    if (self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
    
    
}

#pragma mark - Private Method

+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
   
    
    appearance.translucent = NO;
    [appearance setShadowImage:[UIImage new]];
    [appearance setTintColor:UIColor.whiteColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColor.whiteColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20.0f];
    [appearance setTitleTextAttributes:textAttrs];
    //    [appearance setTitleVerticalPositionAdjustment:-14 forBarMetrics:UIBarMetricsDefault];
    //    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    //    [barItem setBackgroundVerticalPositionAdjustment:-14 forBarMetrics:UIBarMetricsDefault];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
