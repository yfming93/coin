//
//  FMNewsTableViewCell.m
//  Client
//
//  Created by mingo on 2021/1/13.
//

#import "FMNewsTableViewCell.h"

@implementation FMNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FMNewsModel *)model {
    _model = model;
    self.title.text = model.title.length > 0 ? model.title : @"";
    self.createTime.text = model.createTime.length > 0 ? model.createTime : @"-";
    self.readKCount.text = model.readKCount.length > 0 ? model.readKCount : @"0";
    [self.thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:model.thumbnailUrl.length > 0 ? model.thumbnailUrl : @"-"] placeholderImage:[UIImage imageNamed:@"pic_zwt"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end
