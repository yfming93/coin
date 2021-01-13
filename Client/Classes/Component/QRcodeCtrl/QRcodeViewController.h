//
//  QRcodeViewController.h
//  Taidi
//
//  Created by eric on 2017/12/15.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "FMBaseViewController.h"

@interface QRcodeViewController : FMBaseViewController
@property(nonatomic,strong)void (^scanResultCallBack)(NSString *serialcode);

@property(nonatomic,strong)void (^afterDoSomethingCallBack)(NSString *serialcode);

@end
