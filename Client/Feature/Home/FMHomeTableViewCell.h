//
//  FMHomeTableViewCell.h
//  Client
//
//  Created by mingo on 2021/1/7.
//

#import <UIKit/UIKit.h>
#import "FMHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, copy) FMHomeModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailUrl;
@property (weak, nonatomic) IBOutlet UIImageView *authAvatar;
@property (weak, nonatomic) IBOutlet UILabel *auth;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@end

NS_ASSUME_NONNULL_END
