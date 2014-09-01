//
//  VideoPlay.h
//  XAEnglishProject
//
//  Created by baojuan on 14-9-1.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPlay : NSObject
- (id)initWithDelegate:(UIViewController *)delegate name:(NSString *)name url:(NSString *)url;

- (void)videoPlay;

@end
