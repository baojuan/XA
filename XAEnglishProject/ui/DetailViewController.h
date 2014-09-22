//
//  DetailViewController.h
//  XAEnglishProject
//
//  Created by baojuan on 14-8-12.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

//模块内容
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, strong)NSString *navigationTitle;
@property (nonatomic, strong)NSArray *modelArray;
@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, strong) NSDictionary *clientInfo;
@end
