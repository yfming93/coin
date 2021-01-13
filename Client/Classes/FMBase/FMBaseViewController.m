//
//  FMBaseViewController.m
//  Client
//
//  Created by mingo on 2018/6/5.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "FMBaseViewController.h"


@interface FMBaseViewController ()
@end

@implementation FMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 1;
    if (self.view.backgroundColor == nil ||self.view.backgroundColor == UIColor.clearColor ) {
        self.view.backgroundColor = [UIColor whiteColor];
    }

//    self.automaticallyAdjustsScrollViewInsets = NO;
  
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


@end
