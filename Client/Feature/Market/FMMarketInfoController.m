//
//  FMMarketInfoController.m
//  Client
//
//  Created by mingo on 2021/1/19.
//

#import "FMMarketInfoController.h"

@interface FMMarketInfoController ()
@property (weak, nonatomic) IBOutlet UILabel *la1;
@property (weak, nonatomic) IBOutlet UILabel *la2;
@property (weak, nonatomic) IBOutlet UILabel *la3;
@property (weak, nonatomic) IBOutlet UILabel *la4;
@property (weak, nonatomic) IBOutlet UILabel *la5;

@end

@implementation FMMarketInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.model = _model;
}

-(void)setModel:(FMMarketModel *)model {
    _model = model;
    self.la1.text = model.la1;
    self.la2.text = model.la2;
    self.la3.text = model.la3;
    self.la4.text = model.la4;
    self.la5.text = [NSString stringWithFormat:@"%@亿",model.la5];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
