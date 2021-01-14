//
//  FMLoginViewController.m
//  Client
//
//  Created by mingo on 2021/1/14.
//

#import "FMLoginViewController.h"
#import "FMRegisterViewController.h"

@interface FMLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn01;
@property (weak, nonatomic) IBOutlet UIButton *btn02;
@property (weak, nonatomic) IBOutlet UITextField *tf01;
@property (weak, nonatomic) IBOutlet UITextField *tf02;

@end 

@implementation FMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.btn02 setBackgroundColor:kMainColor forState:0];
    [[_btn01 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        FMRegisterViewController *vc =FMRegisterViewController.new;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[_btn02 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.view endEditing:YES];
        if (!self.tf01.text.length ) {
            [FMCoreTools fm_showHudText:@"请输入用户名"];
            return;
        }
        if (!self.tf02.text.length ) {
            [FMCoreTools fm_showHudText:@"请输入密码"];
            return;
        }
        BOOL caninName = NO;
        BOOL caninPwd = NO;
        NSArray *arr = kUserInfo.dic.allKeys;
        for (NSString *str in arr) {
            NSLog(@"str11--:%@",str);
            NSLog(@"str21-----self.tf01.text:%@",self.tf01.text);

            if ([str isEqualToString:self.tf01.text]) {
                caninName = YES;
                NSLog(@"str21-----1:%@",str);

            }
        }
        
        NSArray *arr2 = kUserInfo.dic.allValues;
        for (NSString *str in arr2) {
            NSLog(@"str21--:%@",str);
            NSLog(@"str21-----self.tf02.text:%@",self.tf02.text);
            if ([str isEqualToString:self.tf02.text]) {
                caninPwd = YES;
                NSLog(@"str21-----2:%@",str);
            }
        }
        
        if (caninName && caninPwd) {
            kUserInfo.token = self.tf01.text;
            kPopViewControllerWithAnimated
        }else{
            [FMCoreTools fm_showHudText:@"用户名或者密码错误"];
        }
        
        
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
