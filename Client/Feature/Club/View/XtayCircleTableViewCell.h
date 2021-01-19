//
//  XtayCircleTableViewCell.h
//  FriendCircleDemo
//
//  Created by admin on 2021/1/15.
//

#define AVATAR_W_H            50
#define CONTENT_SHOW_MAXH     150

@class XtayCircleModel, XtayCircleTableViewCell;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XtayCircleCellDelegate <NSObject>

/// 展开收缩按钮的回调方法
/// @param isOpen 当前状态是开还是关
/// @param cell 自身
- (void)openOrCloseBtnResponseWithCurrentStatus:(BOOL)isOpen cell:(XtayCircleTableViewCell *)cell;

/// 查看图片
/// @param index 点击的当前索引值
/// @param cell 自身
- (void)lookCellImagesWithIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell;

/// 点击点赞的人的回调
/// @param index 当前排序索引值
/// @param cell 自身
- (void)clickThumbViewListWithIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell;

/// 点击评论视图的回复者方法
/// @param index 第几条数据
/// @param cell 自身
- (void)clickCommentListViewFromManIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell;

/// 点击评论视图的被回复对象方法
/// @param index 第几条数据
/// @param cell 自身
- (void)clickCommentListViewToManIndex:(NSInteger)index cell:(XtayCircleTableViewCell *)cell;

/// 更多按钮的回调事件
/// @param cell 自身
- (void)moreButtonCallBackCell:(XtayCircleTableViewCell *)cell;

/// 点赞按钮点击事件回调
/// @param cell 自身
- (void)moreBtnSubViewDianZanResCell:(XtayCircleTableViewCell *)cell;

/// 取消点赞按钮点击事件回调
/// @param cell 自身
- (void)moreBtnSubViewCancelDianZanResCell:(XtayCircleTableViewCell *)cell;

/// 回复按钮点击事件回调
/// @param cell 自身
- (void)moreBtnSubViewHuiFuResCell:(XtayCircleTableViewCell *)cell;

@end

@interface XtayCircleTableViewCell : UITableViewCell

/// model
@property (nonatomic, strong) XtayCircleModel *model;

/// XtayCircleCellDelegate
@property (nonatomic, weak) id <XtayCircleCellDelegate> cellDelegate;

@end

NS_ASSUME_NONNULL_END
