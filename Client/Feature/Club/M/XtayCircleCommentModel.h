//
//  XtayCircleCommentModel.h
//  FriendCircleDemo
//
//  Created by admin on 2021/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XtayCircleCommentModel : NSObject

+ (XtayCircleCommentModel *)obtainModelWithCircleDict:(NSDictionary *)circleDic;

/// from
@property (nonatomic, copy) NSString *from;
/// to
@property (nonatomic, copy) NSString *to;
/// cont
@property (nonatomic, copy) NSString *cont;

@end

NS_ASSUME_NONNULL_END
