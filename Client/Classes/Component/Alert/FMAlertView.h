//
//  FMAlertView.h
//  Client
//
//  Created by mingo on 2019/7/31.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UILabel *subtips;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *sure;
@property (weak, nonatomic) IBOutlet UIButton *tick;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tick_w;

/** <#注释#>*/
@property (nonatomic, assign) BOOL show;
- (void)fm_title:(NSString *)title tip:(NSString *)tip subtip:(NSString *)subtip cancelBlock:(void(^)(id objc ))cancelBlock sureBlock:(void(^)(id objc))sureBlock;
@end

