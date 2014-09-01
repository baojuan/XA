//
//  UploadCell.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-18.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadCellDelegate <NSObject>

- (void)deleteDict:(NSDictionary *)dict;

- (void)addToUploadArray:(NSDictionary *)dict;
- (void)deleteToUploadArray:(NSDictionary *)dict;


@end

@interface UploadCell : UICollectionViewCell
@property (weak, nonatomic) id<UploadCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
- (IBAction)rightButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
- (IBAction)uploadButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteButtonClick:(id)sender;
- (IBAction)playButtonClick:(UIButton *)sender;
- (void)insertIntoData:(NSDictionary *)dict;
@property (nonatomic, assign) BOOL uploadAll;
@property (nonatomic, assign) BOOL isDelete;

@end
