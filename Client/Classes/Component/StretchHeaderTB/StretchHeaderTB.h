//
//  StretchHeaderTB.h
//  Client
//
//  Created by mingo on 2018/6/14.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StretchHeaderTB : NSObject

@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) UIView* view;


/**
 * subview:内容部分
 * view   :拉伸的背景图片
 */
- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                         subViews:(UIView*)subview;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

- (void)resizeView;

@end
