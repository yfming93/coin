//
//  XtayCircleModel.h
//  FriendCircleDemo
//
//  Created by admin on 2021/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XtayCircleModel : NSObject

+ (XtayCircleModel *)obtainModelWithCircleDict:(NSDictionary *)circleDic;

/// avata
@property (nonatomic, copy) NSString *avata;
/// name
@property (nonatomic, copy) NSString *name;
/// content
@property (nonatomic, copy) NSString *content;
/// time
@property (nonatomic, copy) NSString *time;
/// images
@property (nonatomic, copy) NSArray *images;
/// thumb
@property (nonatomic, copy) NSArray *thumb;
/// comment
@property (nonatomic, copy) NSArray *comment;
/// hasLiked
@property (nonatomic, assign) BOOL hasLiked;
/// isOpen
@property (nonatomic, assign) BOOL isOpen;
/// isMoreViewShow
@property (nonatomic, assign) BOOL isMoreViewShow;

@end

NS_ASSUME_NONNULL_END
