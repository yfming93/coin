//
//  FMBaseView.m
//  Client
//
//  Created by mingo on 2019/3/15.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import "FMBaseView.h"

@implementation FMBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self fm_addInit];
        
    }
    return self;
}
- (void)fm_addInit {
    
}




@end
