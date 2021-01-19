//
//  XtayCircleThumbView.h
//  FriendCircleDemo
//
//  Created by admin on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XtayThumbViewDelegate <NSObject>

- (void)chosedResponseIndex:(NSInteger)index;

@end

@interface XtayCircleThumbView : UIView

- (void)creatThumbViewWithThumbArr:(NSArray *)thumbArr;

/// 代理
@property (nonatomic, weak) id <XtayThumbViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
