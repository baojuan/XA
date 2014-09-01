//
//  AddCustomerView.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-7.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "AddCustomerView.h"

@implementation AddCustomerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self.coverView addGestureRecognizer:ges];
        
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.coverView addGestureRecognizer:ges];
}

- (void)tapClick
{
    [self.customNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (IBAction)addButtonClick:(id)sender {
    [self addCustomerRequest];
}

- (IBAction)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (void)addCustomerRequest
{
    if (![UtilClass validateMobile:self.phoneTextField.text]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"手机号输入错误";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    if ([self.customNameTextField.text length] == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入客户姓名";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;

    }
    NSString *saler_id = [NSString stringWithFormat:@"%d",[[[[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"] objectForKey:@"id"] integerValue]];
    
    NSDictionary *dict = @{@"name": self.customNameTextField.text,@"phone":self.phoneTextField.text,@"sex":(self.sexSegment.selectedSegmentIndex == 0 ? @"0":@"1"),@"saler_id": saler_id};
    
    
//    NSDictionary *dict = @{@"name": self.customNameTextField.text,@"phone":self.phoneTextField.text,@"sex":(self.sexSegment.selectedSegmentIndex == 0 ? @"男":@"女"),@"image":UIImagePNGRepresentation(self.avatarImageView.image),@"saler_id": saler_id};

    
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithPostUrl:[NSString stringWithFormat:@"%@/api/user/client",HOST] delegate:self dict:dict finishMethod:@"finishMethod:" failMethod:@"failMethod:"];
}

- (void)finishMethod:(NSData *)data
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict[@"msg"]);
    [self removeFromSuperview];
    [self.delegate addCustomerSuccess];
}

- (void)failMethod:(NSError *)error
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"添加失败，原因：%@",error];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

@end
