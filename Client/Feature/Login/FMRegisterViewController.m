//
//  FMRegisterViewController.m
//  Client
//
//  Created by mingo on 2021/1/14.
//

#import "FMRegisterViewController.h"

@interface FMRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn01;
@property (weak, nonatomic) IBOutlet UIButton *btn02;
@property (weak, nonatomic) IBOutlet UITextField *tf01;
@property (weak, nonatomic) IBOutlet UITextField *tf02;

@end

@implementation FMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self.btn01 setBackgroundColor:kMainColor forState:0];
    [[_btn01 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (!self.tf01.text.length ) {
            [FMCoreTools fm_showHudText:@"请输入用户名"];
            return;
        }
        if (!self.tf02.text.length ) {
            [FMCoreTools fm_showHudText:@"请输入密码"];
            return;
        }
        [kUserInfo.dic setValue:self.tf02.text forKey:self.tf01.text];
        [FMDiskConfigUtill.sharedInstance saveUserInfoModel:kUserInfo];
        [FMCoreTools fm_showHudText:@"注册成功！"];
        kPopViewControllerWithAnimated
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
