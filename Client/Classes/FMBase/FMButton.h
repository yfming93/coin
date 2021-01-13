//
//  FMButton.h
//  Client
//
//  Created by mingo on 2019/3/26.
//  Copyright © 2019年 mingo. All rights reserved.
//

#import "FMBaseButton.h"

@interface FMButton : FMBaseButton
- (void)fm_viewModelRacCommand:(RACCommand *)racCommand needLoading:(BOOL)needLoading  userInteractionEnabled:(BOOL)enabled subscribeTargetBtn:(void (^)(FMButton  *fmbtn))btnBlock subscribeNext:(void (^)(id x))nextBlock;
- (void)fm_viewModelRacCommand:(RACCommand *)racCommand needLoading:(BOOL)needLoading userInteractionEnabled:(BOOL)enabled subscribeNext:(void (^)(id x))nextBlock;
@end
