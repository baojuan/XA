//
//  PriceForModel.h
//  XAEnglishProject
//
//  Created by baojuan on 14-9-16.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceGraph.h"
@interface PriceForModel : UIView <UITableViewDataSource, UITableViewDelegate,PriceGraphDelegate>
@property (nonatomic, strong) PriceGraph *graph;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)insertIntoData:(NSArray *)array;

@end
