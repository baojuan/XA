//
//  PersonalViewController.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

//个人中心
#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
- (IBAction)saleRecordButtonClick:(id)sender;
- (IBAction)helpButtonClick:(id)sender;
- (IBAction)myRecordButtonClick:(id)sender;
- (IBAction)logoutButtonClick:(id)sender;

@end
