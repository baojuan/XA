//
//  PriceGraph.h
//  XAEnglishProject
//
//  Created by baojuan on 14-9-16.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PriceGraphDelegate <NSObject>

- (void)priceDelegate:(NSInteger)number;

@end

@interface PriceGraph : UIView
- (id)initWithArray:(NSArray *)array;
@property (nonatomic, weak) id <PriceGraphDelegate> delegate;
@end
