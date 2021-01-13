//
//  FMNewsTableViewCell.h
//  Client
//
//  Created by mingo on 2021/1/13.
//

#import <UIKit/UIKit.h>
#import "FMNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailUrl;
@property (weak, nonatomic) IBOutlet UILabel *readKCount;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
/** <#注释#>*/
@property (nonatomic, strong) FMNewsModel *model;
@end

NS_ASSUME_NONNULL_END
