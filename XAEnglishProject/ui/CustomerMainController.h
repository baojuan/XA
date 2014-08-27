//
//  CustomerMainController.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

//客户主页
#import <UIKit/UIKit.h>
#import "CustomerMainControllerDelegate.h"

@interface CustomerMainController : UIViewController<CustomerMainControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *customerDict;

@end
