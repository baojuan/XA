//
//  LoginViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-14.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userTextField.delegate = self;
        self.passwordTextField.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userTextField.delegate = self;
    self.passwordTextField.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated
{
    NSDictionary *saler = [[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"];
    if (saler) {
        [self performSegueWithIdentifier:@"LoginViewController" sender:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userTextField) {
        [self.userTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];

    }
    if (textField == self.passwordTextField) {
        [self.userTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self loginButtonClick:self.loginButton];
        
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonClick:(id)sender {
    
    if ([self.userTextField.text length] > 0) {
        if ([self.passwordTextField.text length] > 0) {
            [self sendUserAndPassword];
        }
        else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请输入密码";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }
    else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入用户名";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
 
    
}

- (void)sendUserAndPassword
{
    [self loginRequest];
}

- (void)loginRequest
{
    NSDictionary *dict = @{@"name": self.userTextField.text,@"passwd":self.passwordTextField.text};
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithPostUrl:[NSString stringWithFormat:@"%@/api/user/saler/type/check",HOST] delegate:self dict:dict finishMethod:@"finishMethod:" failMethod:@"failMethod:"];
}

- (void)finishMethod:(NSData *)data
{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([dict[@"code"] intValue] == 0) {
        if ([dict[@"extra"] isKindOfClass:[NSDictionary class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"extra"] forKey:@"saler_info"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"LoginViewController" sender:self];
            return;
        }
        
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"登录失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];

}

- (void)failMethod:(NSError *)error
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"登录失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}




- (void)aTempMethod
{
    [[NSUserDefaults standardUserDefaults] setObject:@{@"saler_id": @"19"} forKey:@"saler_info"];
}

@end
