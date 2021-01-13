//
//  FMHeaderSegeView.h
//  Client
//
//  Created by mingo on 2019/11/19.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMBaseView.h"

//typedef void (^<#blockName#>)(<#arguments#>);

typedef NS_ENUM(NSInteger, FMHeaderSegeType) {
    FMHeaderSegeTypeNone = 0,
    FMHeaderSegeTypeUpon,
    FMHeaderSegeTypeDown,
};

@interface FMHeaderSegeItem : FMBaseObject
@property (nonatomic,strong) NSMutableArray <NSString *>*images;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) UIFont *font;
@property (nonatomic,copy) UIColor *normalColor;
@property (nonatomic,copy) UIColor *selectColor;

@property (nonatomic,assign) FMHeaderSegeType type;
- (instancetype)initWithName:(NSString *)name images:(NSMutableArray <NSString *>*)images font:(UIFont *)font normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor;
@end

@interface FMHeaderSegeView : FMBaseView
@property (nonatomic,strong) UIButton *seletedButton;
@property (nonatomic,strong) UIView *lineV;


- (instancetype)initWithFrame:(CGRect)frame arrTitles:(NSMutableArray <FMHeaderSegeItem *>*)itemArr indexSelect:(NSInteger)index  lineSelectColor:(UIColor *)lineSelectColor segeSelectBlock:(void(^)(id objc,NSInteger index))segeSelectBlock;
@end

