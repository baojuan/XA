//
//  PriceTableViewCell.h
//  XAEnglishProject
//
//  Created by baojuan on 14-9-16.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceTableViewCell : UITableViewCell
- (void)insertIntoData:(NSArray *)array withNumber:(NSInteger)number withIndexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;

@end
