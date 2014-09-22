//
//  PersonalViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "PersonalViewController.h"
#import "XAImagePickerController.h"
@interface PersonalViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab2_S"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    self.avatar.layer.cornerRadius = 60;
    self.avatar.layer.masksToBounds = YES;
    
    self.avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker)];
    [self.avatar addGestureRecognizer:tap];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"];
    [self.avatar setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@"person_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image == nil) {
            return ;
        }
        self.avatar.image = image;
    }];
    self.userName.text = dict[@"name"];
}


- (void)showPicker
{
	XAImagePickerController *picker = [[XAImagePickerController alloc] init];
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	picker.delegate = self;
	[self presentViewController:picker animated:YES completion:^{
        ;
    }];
	
}

#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
    self.avatar.image = aImage;
    [picker dismissModalViewControllerAnimated:YES];
    [self uploadAvatarImage];
}

- (void)uploadAvatarImage
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"];

    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithPutUrl:[NSString stringWithFormat:@"%@/api/user/saler/%@/image",HOST,dict[@"id"]] delegate:self data:UIImageJPEGRepresentation(self.avatar.image, 1.0) finishBlock:^(NSData *data) {
        NSLog(@"%@",data);
        NSDictionary *dd = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:dd[@"data"] forKey:@"saler_info"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failBlock:^{
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saleRecordButtonClick:(id)sender {
}

- (IBAction)helpButtonClick:(id)sender {
}


- (IBAction)logoutButtonClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saler_info"];

    [self performSegueWithIdentifier:@"LogoutButtonClick" sender:self];
}


- (void)customerArrayRequest
{
    NSString *saler_id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"] objectForKey:@"id"];
    
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/user/saler?saler_id=%@",HOST,saler_id] delegate:self finishMethod:@"finishMethod:" failMethod:@"failMethod:"];
}

- (void)finishMethod:(NSData *)data
{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([dict[@"code"] intValue] == 0) {
        
        
    }
}

- (void)failMethod:(NSError *)error
{
    
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


@end
