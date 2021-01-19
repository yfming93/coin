//
//  XtayCommentInputView.h
//  FriendCircleDemo
//
//  Created by admin on 2021/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XtayInputContentFinishedProtocol <NSObject>

- (void)finishedInputWithSendContent:(NSString *)content;

@end

@interface XtayCommentInputView : UIView

/// 代理
@property (nonatomic, weak) id <XtayInputContentFinishedProtocol> delegate;

- (void)beginShowInputView;

- (void)beginHiddenInputView;

/// placeHolder
@property (nonatomic, strong) NSString *placeHolder;

@end

NS_ASSUME_NONNULL_END
