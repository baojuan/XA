//
//  AddCustomerView.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-7.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "AddCustomerView.h"
#import "XAImagePickerController.h"

@implementation AddCustomerView
{
    BOOL image;
}

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
    self.customNameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker)];
    [self.avatarImageView addGestureRecognizer:tap];
    self.avatarImageView.userInteractionEnabled = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.customNameTextField) {
        [self.customNameTextField resignFirstResponder];
        [self.phoneTextField becomeFirstResponder];
    }
    if (textField == self.phoneTextField) {
        [self.customNameTextField resignFirstResponder];
        [self.phoneTextField resignFirstResponder];
        [self addButtonClick:self.addButton];
    }
    return YES;
}

- (void)showPicker
{
	XAImagePickerController *picker = [[XAImagePickerController alloc] init];
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	picker.delegate = self;
	[((UIViewController *)self.delegate) presentViewController:picker animated:YES completion:^{
        ;
    }];
	
}

#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    image = YES;
    self.avatarImageView.image = aImage;
    [picker dismissModalViewControllerAnimated:YES];
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


- (void)uploadAvatarImage:(NSString *)client_id
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"];
    
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithPutUrl:[NSString stringWithFormat:@"%@/api/user/client/%@/image",HOST,client_id] delegate:self data:UIImageJPEGRepresentation(self.avatarImageView.image, 1.0) finishBlock:^(NSData *data) {
        NSLog(@"%@",data);
        NSDictionary *dd = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.delegate addCustomerSuccess];

    } failBlock:^{
        [self.delegate addCustomerSuccess];

    }];
}


- (void)finishMethod:(NSData *)data
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict[@"msg"]);
    [self removeFromSuperview];
    if (image == YES) {
        [self uploadAvatarImage:dict[@"data"][@"id"]];

    }
    else {
        [self.delegate addCustomerSuccess];

    }

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
