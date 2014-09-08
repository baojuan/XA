//
//  AddCustomerView.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-7.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCustomerViewDelegate <NSObject>

- (void)addCustomerSuccess;

@end


@interface AddCustomerView : UIView<UITextFieldDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) id <AddCustomerViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *customNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)addButtonClick:(id)sender;
- (IBAction)cancelButtonClick:(id)sender;

@end
