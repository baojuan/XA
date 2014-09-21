//
//  PriceTableViewCell.m
//  XAEnglishProject
//
//  Created by baojuan on 14-9-16.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//






#import "PriceTableViewCell.h"
#define COLOR1 RGBCOLOR(255, 222, 190)

#define COLOR2 RGBCOLOR(255, 234, 213)


@implementation PriceTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)insertIntoData:(NSArray *)array withNumber:(NSInteger)number withIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0) {
        self.monthLabel.backgroundColor = self.timeLabel.backgroundColor = self.levelLabel.backgroundColor = self.price.backgroundColor = self.averageLabel.backgroundColor = COLOR1;
    }
    else {
        self.monthLabel.backgroundColor = self.timeLabel.backgroundColor = self.levelLabel.backgroundColor = self.price.backgroundColor = self.averageLabel.backgroundColor = COLOR2;

    }
    NSDictionary *dict;
    if (number == -1) {
        dict = array[indexPath.row];
    }
    else {
        dict = array[number];
    }
    self.monthLabel.text = [NSString stringWithFormat:@"%@",dict[@"over_time"]];
    self.levelLabel.text = [NSString stringWithFormat:@"%@",dict[@"level"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",dict[@"hour"]];
    self.price.text = [NSString stringWithFormat:@"%@",dict[@"price"]];
    self.averageLabel.text = [NSString stringWithFormat:@"%@",dict[@"average"]];

    
}

@end
