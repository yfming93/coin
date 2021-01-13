//
//  SegmentViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/26.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "SegmentViewController.h"

#define HEADBTN_TAG                 10000
#define Default_BottomLineColor     [UIColor redColor]
#define Default_BottomLineHeight    2
#define Default_ButtonHeight        kFit_6H(45)
#define Default_TitleColor          [UIColor blackColor]
#define Default_HeadViewBackgroundColor  [UIColor whiteColor]
#define Default_FontSize            16
#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight            [[UIScreen mainScreen]bounds].size.height

@interface SegmentViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *headerView;
//@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initSegment
{
    [self addButtonInScrollHeader:_titleArray];
    [self addContentViewScrollView:_subViewControllers];
}

/*!
 *  @brief  根据传入的title数组新建button显示在顶部scrollView上
 *
 *  @param titleArray  title数组
 */
- (void)addButtonInScrollHeader:(NSArray *)titleArray
{
    self.headerView.frame = CGRectMake(0, self.topToNav, MainScreenWidth, self.buttonHeight);
    if (_segmentHeaderType == 0) {
        self.headerView.contentSize = CGSizeMake(self.buttonWidth * titleArray.count, self.buttonHeight);
    }
    else {
        self.headerView.contentSize = CGSizeMake(MainScreenWidth, self.buttonHeight);
    }
    [self.view addSubview:self.headerView];
    UIView *lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.height-1.0, self.buttonWidth * titleArray.count, 1.f)];
    
    [lineBottom setBackgroundColor:self.bottomScreenLineColor];
    
    [_headerView addSubview:lineBottom];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(self.buttonWidth * index,0, self.buttonWidth, self.buttonHeight);
        [segmentBtn setTitle:titleArray[index] forState:UIControlStateNormal];
        segmentBtn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        segmentBtn.tag = index + HEADBTN_TAG;
        [segmentBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [segmentBtn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:segmentBtn];
        if (index == 0) {
            segmentBtn.selected = YES;
            self.selectIndex = segmentBtn.tag;
            [segmentBtn setBackgroundImage:[self imageWithColor:self.itemSelectedBackColor] forState:0];

        }
    }
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonHeight - self.bottomLineHeight, self.buttonWidth, self.bottomLineHeight)];
    UIView *lineSelet = [[UIView alloc] initWithFrame:CGRectMake((self.buttonWidth - self.bottomLineWidth )/2,0, self.bottomLineWidth, self.bottomLineHeight)];
    lineSelet.backgroundColor = self.bottomLineColor;
    [self.headerView addSubview:_lineView];
    [_lineView addSubview:lineSelet];
}


/*!
 *  @brief  根据传入的viewController数组，将viewController的view添加到显示内容的scrollView
 *
 *  @param subViewControllers  viewController数组
 */
- (void)addContentViewScrollView:(NSArray *)subViewControllers
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.buttonHeight + self.topToNav, MainScreenWidth, (self.view.frame.size.height) - self.buttonHeight - (self.topToNav))];
    _mainScrollView.contentSize = CGSizeMake(MainScreenWidth * subViewControllers.count, (self.view.frame.size.height) - self.buttonHeight - (self.topToNav));
    [_mainScrollView setPagingEnabled:YES];
    if (_segmentControlType == 0) {
        _mainScrollView.scrollEnabled = YES;
    }
    else {
        _mainScrollView.scrollEnabled = NO;
    }
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    weakSelf(self)
    [subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *viewController = (UIViewController *)weakSelf.subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * MainScreenWidth, 0, MainScreenWidth, (weakSelf.mainScrollView.frame.size.height));
        [weakSelf.mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
    
}

- (void)addParentView:(UIView *)view
{
    if (view) {
        [view addSubview:self.view];
    }
}

- (void)btnClick:(UIButton *)button
{
    [_mainScrollView scrollRectToVisible:CGRectMake((button.tag - HEADBTN_TAG) *MainScreenWidth, 0, MainScreenWidth, _mainScrollView.frame.size.height) animated:YES];
    [self didSelectSegmentIndex:button.tag];
}

/*!
 *  @brief  设置顶部选中button下方线条位置
 *
 *  @param index 第几个
 */
- (void)didSelectSegmentIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
    btn.selected = NO;
    [btn setBackgroundImage:[self imageWithColor:self.itemBackColor] forState:0];

    self.selectIndex = index;
    UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:index];
    currentSelectBtn.selected = YES;
    [currentSelectBtn setBackgroundImage:[self imageWithColor:self.itemSelectedBackColor] forState:0];
    CGRect rect = self.lineView.frame;
    rect.origin.x = (index - HEADBTN_TAG) * _buttonWidth;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = rect;
    }];
}

// 设置颜色
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        float xx = scrollView.contentOffset.x * (_buttonWidth / MainScreenWidth) - _buttonWidth;
        [_headerView scrollRectToVisible:CGRectMake(xx, 0, MainScreenWidth, _headerView.frame.size.height) animated:YES];
        NSInteger currentIndex = scrollView.contentOffset.x / MainScreenWidth;
        [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    float xx = scrollView.contentOffset.x * (_buttonWidth / MainScreenWidth) - _buttonWidth;
    [_headerView scrollRectToVisible:CGRectMake(xx, 0, MainScreenWidth, _headerView.frame.size.height) animated:YES];
}

#pragma mark - setter/getter
- (UIScrollView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIScrollView alloc] init];
        [_headerView setShowsVerticalScrollIndicator:NO];
        [_headerView setShowsHorizontalScrollIndicator:NO];
        _headerView.bounces = NO;
        _headerView.backgroundColor = self.headViewBackgroundColor;
    }
    return _headerView;
}

- (UIColor *)headViewBackgroundColor
{
    if (_headViewBackgroundColor == nil) {
        _headViewBackgroundColor = Default_HeadViewBackgroundColor;
    }
    return _headViewBackgroundColor;
}

- (UIColor *)titleColor
{
    if (_titleColor == nil) {
        _titleColor = Default_TitleColor;
    }
    return _titleColor;
}

//- (UIColor *)itemBackColor
//{
//    if (_itemBackColor == nil) {
//        _itemBackColor = UIColor.clearColor;
//    }
//    return _itemBackColor;
//}
//
//- (UIColor *)itemSelectedBackColor
//{
//    if (_itemSelectedBackColor == nil) {
//        _itemSelectedBackColor = UIColor.clearColor;
//    }
//    return _itemSelectedBackColor;
//}

- (UIColor *)bottomScreenLineColor
{
    if (_bottomScreenLineColor == nil) {
        _bottomScreenLineColor = self.headViewBackgroundColor;
    }
    return _bottomScreenLineColor;
}

- (UIColor *)titleSelectedColor
{
    if (_titleSelectedColor == nil) {
//        _titleSelectedColor = Default_TitleColor;
        _titleSelectedColor = [UIColor colorWithRed:0.118 green:0.549 blue:0.780 alpha:1.000];
    }
    return _titleSelectedColor;
}

- (CGFloat)fontSize
{
    if (_fontSize == 0) {
        _fontSize = Default_FontSize;
    }
    return _fontSize;
}

- (CGFloat)buttonWidth
{
    if (_buttonWidth == 0) {
        _buttonWidth = self.titleArray.count ?  MainScreenWidth / self.titleArray.count : MainScreenWidth;
    }
    return _buttonWidth;
}

- (CGFloat)buttonHeight
{
    if (_buttonHeight == 0) {
        _buttonHeight = Default_ButtonHeight;
    }
    return _buttonHeight;
}

- (CGFloat)bottomLineHeight
{
    if (_bottomLineHeight == 0) {
        _bottomLineHeight = Default_BottomLineHeight;
    }
    return _bottomLineHeight;
}

- (CGFloat)bottomLineWidth
{
    if ((_bottomLineWidth == 0) | (_bottomLineWidth > self.buttonWidth)) {
        _bottomLineWidth = self.buttonWidth;
    }
    return _bottomLineWidth;
}

//- (UIColor *)bottomLineColor
//{
//    if (_bottomLineColor == nil) {
//        _bottomLineColor = UIColor.clearColor;
//    }
//    return _bottomLineColor;
//}


@end
