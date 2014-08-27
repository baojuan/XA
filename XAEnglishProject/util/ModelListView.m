//
//  ModelListView.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "ModelListView.h"

@implementation ModelListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.addView.layer.cornerRadius = 5;
    self.addView.layer.masksToBounds = YES;
}


- (IBAction)topicButtonClick:(id)sender {
    [self.delegate addTopicButtonClick];
    [self removeFromSuperview];
}

- (IBAction)assistButtonClick:(id)sender {
    [self.delegate addAssistButtonClick];
    [self removeFromSuperview];
}
- (IBAction)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}
@end
