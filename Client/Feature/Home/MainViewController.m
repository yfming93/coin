    //
    //  MainViewController.m
    //  UISegmentedControl
    //
    //  Created by 谢鑫 on 2019/7/17.
    //  Copyright © 2019 Shae. All rights reserved.
    //


#import "MainViewController.h"
#import "ZFNotAutoPlayViewController.h"
#import "FMNewsViewController.h"
#import "FMHomeViewController.h"


#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kNumber (self.segmentedControl.numberOfSegments)
@interface MainViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
@end

@implementation MainViewController
- (UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.contentSize=CGSizeMake(kScreenWidth*kNumber, 0);
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.pagingEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate=self;
    }
    return _scrollView;
}
- (UISegmentedControl *)segmentedControl{
    if (_segmentedControl==nil) {
        _segmentedControl=[[UISegmentedControl alloc] initWithItems:@[@" 推 荐 ",@" 课 堂 ",@" 资 讯 "]];
        _segmentedControl.tintColor=[UIColor purpleColor];
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(changeIndex) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX=self.scrollView.contentOffset.x;
    CGFloat x=offsetX/kScreenWidth;
    int index=(int)round(x);
    self.segmentedControl.selectedSegmentIndex=index;
}
-(void)changeIndex{
    NSInteger index=self.segmentedControl.selectedSegmentIndex;
    self.scrollView.contentOffset=CGPointMake(index*kScreenWidth, 0);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView =  self.segmentedControl;
    [self.view addSubview:[self scrollView]];
    for (int i=0; i<kNumber; i++) {
        UIViewController *sub =[[UIViewController alloc]init];
        switch (i) {
            case 0:
                sub = FMHomeViewController.new;
                break;
            case 1:
                sub = ZFNotAutoPlayViewController.new;
                break;
            case 2:
                sub = FMNewsViewController.new;
                break;
            default:
                break;
        }
        
        sub.view.frame=CGRectMake(kScreenWidth*i, 0,kScreenWidth , [UIScreen mainScreen].bounds.size.height);
        [self.scrollView addSubview:sub.view];
        [self addChildViewController:sub];
        
    }
}


@end


