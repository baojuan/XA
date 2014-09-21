//
//  PriceGraph.m
//  XAEnglishProject
//
//  Created by baojuan on 14-9-16.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "PriceGraph.h"

static CGFloat height = 768 / 2.0;
static CGFloat width = 106 / 2.0;
static CGFloat space = 38 / 2.0;

static CGFloat maxPrice = 50000.0;

@implementation PriceGraph
{
    
}
- (id)initWithArray:(NSArray *)array
{
    if (self = [super init]) {
        self.frame = RECT(0, 0, 1415 / 2.0, height + 50);
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < [array count]; i++) {
            NSDictionary *dict = array[i];
            CGFloat hh = [[dict objectForKey:@"price"] floatValue] / maxPrice * height;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * (width + space), height - hh, width, hh)];
            button.tag = i + 100;
            button.backgroundColor = RGBCOLOR(0, 96, 225);
            [self addSubview:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, button.frame.size.height - 50, button.frame.size.width, 50)];
            label.textColor = [UIColor whiteColor];
            label.text = [NSString stringWithFormat:@"%@ month",dict[@"over_time"]];
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentCenter;
            [button addSubview:label];
            
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)button
{
    [self.delegate priceDelegate:button.tag - 100];
}
@end
