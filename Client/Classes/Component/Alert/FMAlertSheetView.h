//
//  FMAlertSheetView.h
//  Client
//
//  Created by mingo on 2019/8/2.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMAlertSheetView : UIView
- (instancetype)initWithTitles:(NSMutableArray *)titles atIndex:(NSInteger)atIndex needCancel:(BOOL)needCancel  handlerBlock:(void(^)(id objc, NSInteger index))handlerBlock ;
@property (nonatomic, assign) BOOL show;

@end

NS_ASSUME_NONNULL_END
