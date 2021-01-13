//
//  ViewController.m
//  Client
//
//  Created by mingo on 2018/6/5.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "FMTabBarController.h"
#import "FMBaseViewController.h"

@interface FMTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic,assign) NSInteger  indexFlag;//记录上一次点击tabbar
@end

@implementation FMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTranslucent:NO];
    _indexFlag = 0;
    self.delegate = self;
    [self createViewControllers];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)createViewControllers {
//    self.tabBar.backgroundColor = kBgTabbarColor;
//    self.tabBar.barTintColor = kBgTabbarColor; stretching
//    [self configSubVC:[NSClassFromString(@"FMPledgeViewController") new] title:@"质押" img:@"ic_home" selectImg:@"ic_home_press"];
    [self configSubVC:[NSClassFromString(@"FMHomeViewController") new] title:@"首页" img:@"ic_home" selectImg:@"ic_home_press"];
    [self configSubVC:[NSClassFromString(@"ZFNotAutoPlayViewController") new] title:@"行情" img:@"ic_sort" selectImg:@"ic_sort_press"];
//    [self configSubVC:[NSClassFromString(@"FMMarketViewController") new] title:@"行情" img:@"ic_sort" selectImg:@"ic_sort_press"];
    [self configSubVC:[NSClassFromString(@"FMNewsViewController") new] title:@"资讯" img:@"ic_ecology" selectImg:@"ic_ecology_press"];
    [self configSubVC:[NSClassFromString(@"FMMineViewController") new] title:@"我的" img:@"ic_mine" selectImg:@"ic_mine_press"];

}

- (void)configSubVC:(UIViewController *)vc title:(NSString *)title img:(NSString *)img selectImg:(NSString *)selectImg {
    vc.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:img] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //选中前文字渲染
    NSDictionary *dic1 = @{NSForegroundColorAttributeName : kTabbarNorColor,NSFontAttributeName : [UIFont systemFontOfSize:12.0]};
    //选中后文字渲染
    NSDictionary *dic2 = @{NSForegroundColorAttributeName :kMainColor,NSFontAttributeName : [UIFont systemFontOfSize:12.0]};
    
    FMBaseNavigationController *nav = [[FMBaseNavigationController alloc] initWithRootViewController:vc];
    nav.textColor = kWhiteColor;
    [nav.tabBarItem setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:dic2 forState:UIControlStateSelected];
    nav.backgroundImageOrColor = kMainColor; //FM_IMAGE(@"nav_bg_zs");
    [nav hideNavBottomLine];
    if (@available(iOS 13.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:kTabbarNorColor];
    }

    [self addChildViewController:nav];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        //添加动画
        //放大效果，并回到原位
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.2;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
        animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.1];     //结束伸缩倍数
        [[arry[index] layer] addAnimation:animation forKey:nil];
        self.indexFlag = index;
    }
}

@end
