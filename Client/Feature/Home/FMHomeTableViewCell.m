//
//  FMHomeTableViewCell.m
//  Client
//
//  Created by mingo on 2021/1/7.
//

#import "FMHomeTableViewCell.h"

@implementation FMHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FMHomeModel *)model {
    self.title.text = model.title.length > 0 ? model.title : @"-";
    self.createTime.text = model.createTime.length > 0 ? model.createTime : @"-";
    self.auth.text = model.auth.length > 0 ? model.auth : @"-";
    [self.thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:model.thumbnailUrl.length > 0 ? model.thumbnailUrl : @"-"] placeholderImage:[UIImage imageNamed:@"pic_zwt"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
     [self.authAvatar sd_setImageWithURL:[NSURL URLWithString:model.authAvatar.length > 0 ? model.authAvatar : @"-"] placeholderImage:[UIImage imageNamed:@"pic_zwt"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    
}

@end
