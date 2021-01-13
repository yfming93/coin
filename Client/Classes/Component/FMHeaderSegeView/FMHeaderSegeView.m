//
//  FMHeaderSegeView.m
//  Client
//
//  Created by mingo on 2019/11/19.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMHeaderSegeView.h"

@interface FMHeaderSegeItem(){
}
//@property (nonatomic,copy) NSString *image;
//@property (nonatomic,copy) NSString *name;
//@property (nonatomic,copy) UIFont *font;
//@property (nonatomic,copy) UIColor *normalColor;
//@property (nonatomic,copy) UIColor *selectColor;

@end

@implementation FMHeaderSegeItem
- (instancetype)initWithName:(NSString *)name images:(NSMutableArray <NSString *>*)images font:(UIFont *)font normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor
{
    self = [super init];
    if (self) {
        self.images = images;
        self.name = name;
        self.name = name;
        self.normalColor = normalColor;
        self.selectColor = selectColor;
    }
    return self;
}
@end

@interface FMHeaderSegeView(){
    NSInteger num;
    CGRect viewFrame;//记录尺寸
    UIFont *tFont;
}

@property (nonatomic,strong) NSMutableArray <FMHeaderSegeItem *>*dataArray;
@property (nonatomic,copy) UIColor *lineSelectColor;
@property (nonatomic,copy) void(^segeSelectBlock)(id objc,NSInteger index);

@end

@implementation FMHeaderSegeView

- (instancetype)initWithFrame:(CGRect)frame arrTitles:(NSMutableArray <FMHeaderSegeItem *>*)itemArr indexSelect:(NSInteger)index  lineSelectColor:(UIColor *)lineSelectColor segeSelectBlock:(void(^)(id objc,NSInteger index))segeSelectBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = itemArr;
        num = index;
        viewFrame = frame;
        self.lineSelectColor = lineSelectColor;
        self.segeSelectBlock = segeSelectBlock;
        [self createUI];
    }
    return self;
}


-(void)createUI{
    CGFloat btnW = viewFrame.size.width/_dataArray.count;
    for (NSInteger i = 0; i < _dataArray.count; i ++) {
        FMHeaderSegeItem *item = self.dataArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 0, btnW, viewFrame.size.height - 2);
        [btn setTitle:item.name forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (item.images.count) {
            [btn setImage:[UIImage imageNamed:item.images.firstObject] forState:UIControlStateNormal];
            [btn setImagePosition:FMImagePositionRight spacing:5];
        }
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (item.normalColor) {
            [btn setTitleColor:item.normalColor forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (item.selectColor) {
            [btn setTitleColor:item.selectColor forState:UIControlStateSelected];
        }
        btn.titleLabel.font = tFont;
        if (item.font) {
            btn.titleLabel.font = item.font;
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == num) {
            btn.selected = YES;
            _seletedButton = btn;
            
            CGFloat lineW = [FMCoreTools weightForText:_seletedButton.titleLabel.text];//和按钮文字等宽
            CGFloat lineX = _seletedButton.x + (btn.width - lineW)/2;
            
            _lineV = [[UIView alloc] initWithFrame:CGRectMake(lineX, viewFrame.size.height - 2, lineW, 2)];
            _lineV.backgroundColor = [UIColor redColor];
            if (self.lineSelectColor) {
                _lineV.backgroundColor = self.lineSelectColor;
            }
            [self addSubview:_lineV];
        }
    }
}

#pragma mark - 点击事件
-(void)btnClick:(UIButton *)sender{
    NSInteger index = _seletedButton.tag;
    if (index != sender.tag) {
        self.dataArray[index].type = FMHeaderSegeTypeNone;
        if (self.dataArray[index].images.count) {
            [_seletedButton setImage:[UIImage imageNamed:self.dataArray[index].images[0]] forState:UIControlStateNormal];
        }
    }
    _seletedButton.selected = NO;
    sender.selected = YES;
    _seletedButton = sender;
    FMHeaderSegeItem *item = self.dataArray[sender.tag];
    
    
    if (item.images.count) {
        switch (item.type) {
            case FMHeaderSegeTypeNone:{
                self.dataArray[sender.tag].type = FMHeaderSegeTypeUpon;
                if (item.images.count >= 2 ) {
                    [sender setImage:[UIImage imageNamed:item.images[1]] forState:UIControlStateNormal];
                }
            }
                break;
            case FMHeaderSegeTypeUpon:{
                self.dataArray[sender.tag].type = FMHeaderSegeTypeDown;
                if (item.images.count >= 3 ) {
                    [sender setImage:[UIImage imageNamed:item.images[2]] forState:UIControlStateNormal];
                }
            }
                break;
            case FMHeaderSegeTypeDown:{
                self.dataArray[sender.tag].type = FMHeaderSegeTypeUpon;
                if (item.images.count >= 1 ) {
                    [sender setImage:[UIImage imageNamed:item.images[1]] forState:UIControlStateNormal];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    CGFloat lineW = [FMCoreTools weightForText:_seletedButton.titleLabel.text];//和按钮文字等宽
    CGFloat lineX = _seletedButton.x + (sender.width - lineW)/2;
    weakSelf(self);
    [UIView animateWithDuration:0.2 animations:^{
        CGRect lineFrame = weakSelf.lineV.frame;
        lineFrame.origin.x = lineX;
        lineFrame.size.width = lineW;
        weakSelf.lineV.frame = lineFrame;
    }];
    if (self.segeSelectBlock) {
        self.segeSelectBlock(item,sender.tag);
    }
}

@end
