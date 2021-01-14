//
//  FMMineViewController.m
//  Client
//
//  Created by mingo on 2021/1/5.
//

#import "FMMineViewController.h"
#import "FMAboutViewController.h"
#import "FMLoginViewController.h"
#import "FMAlertView.h"

@interface FMMineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn01;

@property (weak, nonatomic) IBOutlet UIButton *btn02;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (weak, nonatomic) IBOutlet UIView *vv_back;

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
        FMLoginViewController *vc =FMLoginViewController.new;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[_btnLogout rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        FMAlertView *alert = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(FMAlertView.class) owner:nil options:nil].firstObject;;
        [alert fm_title:@"确认退出登录" tip:@"您确定要退出登录吗？" subtip:nil cancelBlock:^(id  _Nonnull objc) {
        } sureBlock:^(id  _Nonnull objc) {
            kUserInfo.token = @"";
            [FMDiskConfigUtill.sharedInstance saveUserInfoModel:kUserInfo];
            [self fm_check];

        }];
        alert.show = YES;
        
    }];
}

- (void)fm_check {
    if (kUserInfo.token.length) {
        [self.btnLogin setTitle:kUserInfo.token forState:0];
        self.btnLogin.userInteractionEnabled = NO;
        self.vv_back.hidden = NO;
    }else{
        [self.btnLogin setTitle:@"去登录" forState:0];
        self.btnLogin.userInteractionEnabled = YES;
        self.vv_back.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fm_check];
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
