//
//  FMMarketTableCell.m
//  Client
//
//  Created by mingo on 2021/1/19.
//

#import "FMMarketTableCell.h"

@implementation FMMarketTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(FMMarketModel *)model {
    _model =model;
    self.la1.text = model.la1;
    self.la2.text = model.la2;
    self.la3.text = model.la3;
    self.la4.text = model.la4;
    self.la5.text = [NSString stringWithFormat:@"%@亿",model.la5];
}

@end
