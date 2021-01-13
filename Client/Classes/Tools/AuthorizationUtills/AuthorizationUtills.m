//
//  AuthorizationUtills.m
//  Taidi
//
//  Created by eric on 2017/11/16.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "AuthorizationUtills.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>

@implementation AuthorizationUtills


+(void)authorizationStateForMedia:(TDMediaType)mediaType withBlcok:(TDAuthorizationBlcok)callBack{
    
    switch (mediaType) {
        case TDCameraType:
        {
            [self handleCameraAuthorization:callBack];
        }
            break;
        case TDLibraryType:
        {
            [self handleLibraryAuthorization:callBack];
        }
            break;
        case TDContactType:
        {
            [self handleContactAuthorization:callBack];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Private

+(void)handleCameraAuthorization:(TDAuthorizationBlcok)block{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusDenied:
        {
            if (block) {
                block(TDAuthorizationDenied);
            }
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    if (block) {
                        block(TDAuthorizationSuccess);
                    }
                }else{
                    if (block) {
                        block(TDAuthorizationDenied);
                    }
                }
                
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            if (block) {
                block(TDAuthorizationDenied);
            }
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            if (block) {
                block(TDAuthorizationSuccess);
            }
        }
            break;
            
        default:
            break;
    }
};

+(void)handleLibraryAuthorization:(TDAuthorizationBlcok)block{
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
                
            case PHAuthorizationStatusNotDetermined:
            {
                if (block) {
                    block(TDAuthorizationDenied);
                }
            }
                break;
            case PHAuthorizationStatusRestricted:
            {
                if (block) {
                    block(TDAuthorizationDenied);
                }
            }
                break;
            case PHAuthorizationStatusDenied:
            {
                if (block) {
                    block(TDAuthorizationSuccess);
                }
            }
                break;
            case PHAuthorizationStatusAuthorized:
            {
                if (block) {
                    block(TDAuthorizationSuccess);
                }
            }
                break;
                
            default:
                break;
        }
    }];
    
};

+(void)handleContactAuthorization:(TDAuthorizationBlcok)block{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusAuthorized:
        {
            if (block) {
                block(TDAuthorizationSuccess);
            }
            
        }
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusNotDetermined:
        {
            if (block) {
                block(TDAuthorizationDenied);
            }
        }
            break;
    }
}
@end
