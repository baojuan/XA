//
//  ScrollViewForModel.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-31.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewForModel : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
- (void)insertIntoData:(NSDictionary *)dict;

@end
