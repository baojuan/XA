//
//  ModelCell.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModelCellDelegate <NSObject>

- (void)cellSelectedOrNot:(BOOL)state modelId:(NSString *)modelId;

- (void)cellDeleteModel:(NSString *)modelId;

@end

@interface ModelCell : UICollectionViewCell
@property (nonatomic, weak) id <ModelCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *modelImageView;
@property (weak, nonatomic) IBOutlet UILabel *modelTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButtom;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, assign) BOOL editing;
- (IBAction)deleteButtonClick:(id)sender;
- (void)insertIntoData:(NSDictionary *)dict;
- (IBAction)rightButtonClick:(UIButton *)sender;

@end
