//
//  RecordPlay.m
//  XAEnglishProject
//
//  Created by baojuan on 14-9-1.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "RecordPlay.h"
#import <AVFoundation/AVFoundation.h>

static RecordPlay *gl_play = nil;

@implementation RecordPlay
{
    NSURL *recordedTmpFile;
    AVAudioPlayer *audioPlayer;
}
+ (RecordPlay *)share
{
    if (!gl_play) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gl_play = [[RecordPlay alloc] init];
        });
    }
    return gl_play;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayHasFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)PlayHasFinished:(NSNotification *)notification
{
    [self.delegate playFinished];
}

- (void) playWithName:(NSString *)name delegate:(id)delegate
{
    self.delegate = delegate;
    [self pause];


    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获得存储路径，
    NSString *documentDirectory = [paths objectAtIndex:0];//获得路径的第0个元素
    NSString *fullPath = [documentDirectory stringByAppendingPathComponent:name];//在第0个元素中添加txt文本
    
    
    
    
    recordedTmpFile = [NSURL fileURLWithPath:fullPath];
    
    
    NSError *error;
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:recordedTmpFile
                                                      error:&error];
    
    audioPlayer.volume=1;
    if (error) {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];
}

- (void)playWithUrl:(NSString *)url
{
    [self pause];
    NSError *error;
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:url]
                                                      error:&error];
    
    audioPlayer.volume=1;
    if (error) {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];

}

- (void)pause
{
    if (audioPlayer.playing) {
        [audioPlayer pause];
    }
}

@end
