//
//  MyRecordViewController.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-18.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecordViewController : UIViewController
- (IBAction)cancelButtonClick:(id)sender;
- (IBAction)uploadButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *allUploadButton;
- (IBAction)allUploadButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *allDeleteButton;
- (IBAction)allDeleteButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBarButton;
- (IBAction)selectSegment:(UISegmentedControl *)sender;
- (IBAction)editBarButtonClick:(UIBarButtonItem *)sender;
@end
