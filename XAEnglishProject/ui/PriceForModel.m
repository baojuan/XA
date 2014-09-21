//
//  PriceForModel.m
//  XAEnglishProject
//
//  Created by baojuan on 14-9-16.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "PriceForModel.h"
#import "PriceTableViewCell.h"
@implementation PriceForModel
{
    NSInteger _number;
    BOOL all;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(316 / 2.0, 194 / 2.0, 1415 / 2.0, 768 / 2.0 + 100);
        self.dataArray = [[NSMutableArray alloc] init];
        all = 0;
        _number = -1;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        button.backgroundColor = RGBCOLOR(255, 144, 25);
        [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        button.frame = RECT(0, self.frame.size.height - 40, 80, 40);
        [self addSubview:button];
        
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setTitle:@"查看全部" forState:UIControlStateNormal];
        button2.backgroundColor = RGBCOLOR(255, 144, 25);
        [button2 addTarget:self action:@selector(allButtonClick) forControlEvents:UIControlEventTouchUpInside];
        button2.frame = RECT(600, self.frame.size.height - 40, 100, 40);
        [self addSubview:button2];
        
    }
    return self;
}

- (void)backButtonClick
{
    self.graph.hidden = NO;
}

- (void)allButtonClick
{
    self.graph.hidden = YES;
    all = YES;
    [self.tableView reloadData];
}

- (void)insertIntoData:(NSArray *)array
{
    [self.dataArray addObjectsFromArray:array];
    self.graph = [[PriceGraph alloc] initWithArray:array];
    self.graph.delegate = self;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.graph.frame.origin.x, self.graph.frame.origin.y, self.graph.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.tableView];
    [self addSubview:self.graph];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    PriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PriceTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (all) {
        [cell insertIntoData:self.dataArray withNumber:-1 withIndexPath:indexPath];

    }
    else {
        [cell insertIntoData:self.dataArray withNumber:_number withIndexPath:indexPath];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (all) {
        return [self.dataArray count];
    }
    else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PriceTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PriceTableViewCell" owner:self options:nil] lastObject];
    cell.monthLabel.backgroundColor = cell.timeLabel.backgroundColor = cell.levelLabel.backgroundColor = cell.price.backgroundColor = cell.averageLabel.backgroundColor = RGBCOLOR(225, 225, 225);
    cell.monthLabel.text = @"完成时间（月）";
    cell.levelLabel.text = @"级别";
    cell.timeLabel.text = @"常规课程/小时";
    cell.price.text = @"课程价格";
    cell.averageLabel.text = @"单课时";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 52;
}

- (void)priceDelegate:(NSInteger)number
{
    _number = number;
    all = NO;
    [self.tableView reloadData];
    self.graph.hidden = YES;
}

@end
