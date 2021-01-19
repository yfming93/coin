//
//  FMMarketTableCell.h
//  Client
//
//  Created by mingo on 2021/1/19.
//

#import <UIKit/UIKit.h>
#import "FMMarketModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FMMarketTableCell : UITableViewCell
proStrongType(FMMarketModel, model)
@property (weak, nonatomic) IBOutlet UILabel *la1;
@property (weak, nonatomic) IBOutlet UILabel *la2;
@property (weak, nonatomic) IBOutlet UILabel *la3;
@property (weak, nonatomic) IBOutlet UILabel *la4;
@property (weak, nonatomic) IBOutlet UILabel *la5;


@end

NS_ASSUME_NONNULL_END
