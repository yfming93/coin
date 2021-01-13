//
//  AuthorizationUtills.h
//  Taidi
//
//  Created by eric on 2017/11/16.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TDAuthorizationUnknow,
    TDAuthorizationSuccess,
    TDAuthorizationDenied,
} TDAuthorizationState;

typedef enum : NSUInteger {
    TDCameraType,
    TDLibraryType,
    TDContactType,
} TDMediaType;


typedef void(^TDAuthorizationBlcok)(TDAuthorizationState statue);
@interface AuthorizationUtills : NSObject


+(void)authorizationStateForMedia:(TDMediaType)mediaType withBlcok:(TDAuthorizationBlcok)callBack;
@end
