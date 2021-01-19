//
//  XtayCircleModel.m
//  FriendCircleDemo
//
//  Created by admin on 2021/1/15.
//

#import "XtayCircleModel.h"

@implementation XtayCircleModel

+ (XtayCircleModel *)obtainModelWithCircleDict:(NSDictionary *)circleDic {
    return [[self alloc] initWithCircleDict:circleDic];
}

- (XtayCircleModel *)initWithCircleDict:(NSDictionary *)circleDic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:circleDic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
