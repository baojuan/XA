//
//  ModelListView.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerMainControllerDelegate.h"
@interface ModelListView : UIView
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIButton *addTopicButton;
@property (weak, nonatomic) IBOutlet UIButton *addAssistButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) id <CustomerMainControllerDelegate> delegate;
- (IBAction)topicButtonClick:(id)sender;
- (IBAction)assistButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButtonClick;
- (IBAction)cancelButtonClick:(id)sender;

@end
