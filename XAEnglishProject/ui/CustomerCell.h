//
//  CustomerCell.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomerCellDelegate <NSObject>

- (void)itemDelete:(NSInteger)modelIndex;

@end


@interface CustomerCell : UICollectionViewCell
@property (nonatomic, weak) id <CustomerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (nonatomic, assign) BOOL editing;
- (IBAction)deleteButtonClick:(id)sender;


- (void)insertIntoData:(NSDictionary *)dict;

@end
