//
//  FMPickerImagesLayoutView.m
//  Client
//
//  Created by mingo on 2019/10/23.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMPickerImagesLayoutView.h"

@interface FMPickerImagesLayoutView ()
@property(nonatomic, assign) NSInteger rowNum;
@property(nonatomic, assign) CGFloat rowGap;
@property(nonatomic, strong) UIImage *placeholderImage;
@end

@implementation FMPickerImagesLayoutView


- (instancetype)initWithFrame:(CGRect)frame rowNum:(NSInteger)rowNum rowGap:(CGFloat)rowGap placeholderImage:(UIImage *)placeholderImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowGap = rowGap;
        self.rowNum = rowNum;
        self.placeholderImage = placeholderImage;
    }
    return self;
}

@end
