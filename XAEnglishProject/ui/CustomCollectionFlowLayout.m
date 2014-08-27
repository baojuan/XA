//
//  CustomCollectionFlowLayout.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "CustomCollectionFlowLayout.h"

@implementation CustomCollectionFlowLayout

- (id)init
{
    if (self = [super init]) {
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)awakeFromNib
{
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
