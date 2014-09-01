//
//  RecordPlay.h
//  XAEnglishProject
//
//  Created by baojuan on 14-9-1.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordPlay : NSObject
+ (RecordPlay *)share;
- (void) playWithName:(NSString *)name;
- (void)playWithUrl:(NSString *)url;
- (void)pause;

@end
