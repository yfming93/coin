
//
//  FMBaseTableView.m
//  Client
//
//  Created by mingo on 2019/10/28.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMBaseTableView.h"

@implementation FMBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
