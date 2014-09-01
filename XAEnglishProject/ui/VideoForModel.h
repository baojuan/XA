//
//  VideoForModel.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-31.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoForModel : UIScrollView
- (void)insertIntoData:(NSDictionary *)dict delegate:(UIViewController *)delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
