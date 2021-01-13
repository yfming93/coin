//
//  FMMineViewController.m
//  Client
//
//  Created by mingo on 2021/1/5.
//

#import "FMMineViewController.h"
#import "FMAboutViewController.h"

@interface FMMineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn01;

@property (weak, nonatomic) IBOutlet UIButton *btn02;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation FMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_btn01 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [FMCoreTools fm_showHudText:@"清除成功！"];
    }];
    [[_btn02 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        FMAboutViewController *vc =FMAboutViewController.new;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[_btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [FMCoreTools fm_showHudText:@"清除成功！"];
    }];
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
