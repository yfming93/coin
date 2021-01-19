//
//  XtayCircleCommentModel.m
//  FriendCircleDemo
//
//  Created by admin on 2021/1/16.
//

#import "XtayCircleCommentModel.h"

@implementation XtayCircleCommentModel

+ (XtayCircleCommentModel *)obtainModelWithCircleDict:(NSDictionary *)circleDic {
    return [[self alloc] initWithCircleDict:circleDic];
}

- (XtayCircleCommentModel *)initWithCircleDict:(NSDictionary *)circleDic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:circleDic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
