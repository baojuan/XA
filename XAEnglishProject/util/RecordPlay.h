//
//  RecordPlay.h
//  XAEnglishProject
//
//  Created by baojuan on 14-9-1.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecordPlayDelegate <NSObject>

- (void)playFinished;

@end

@interface RecordPlay : NSObject
+ (RecordPlay *)share;
@property (nonatomic, strong) id <RecordPlayDelegate>delegate;
- (void) playWithName:(NSString *)name delegate:(id)delegate;
- (void)playWithUrl:(NSString *)url;
- (void)pause;

@end
