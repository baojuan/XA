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
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.avatar.layer.cornerRadius = 15;
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

- (IBAction)uploadButtonClick:(id)sender {
    
}
- (IBAction)logoutButtonClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saler_info"];

    [self performSegueWithIdentifier:@"LogoutButtonClick" sender:self];
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
