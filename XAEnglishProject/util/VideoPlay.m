//
//  VideoPlay.m
//  XAEnglishProject
//
//  Created by baojuan on 14-9-1.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "VideoPlay.h"
#import "ASIHTTPRequest.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NSString+Hashing.h"
@implementation VideoPlay
{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;
    __weak UIViewController *_delegate;
    NSString *_name;
    NSString *_url;
}

- (id)initWithDelegate:(UIViewController *)delegate name:(NSString *)name url:(NSString *)url
{
    self = [super init];
    if (self) {
        _name = name;
        _delegate = delegate;
        _url = url;
    }
    return self;
}

- (void)videoPlay
{
    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Temp"];
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Cache"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([fileManager fileExistsAtPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[_name MD5Hash]]]]) {
        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[_name MD5Hash]]]]];
        [[NSNotificationCenter defaultCenter] addObserver:_delegate selector:@selector(videoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

        [_delegate presentMoviePlayerViewControllerAnimated:playerViewController];
        videoRequest = nil;
    }else{
        ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:_url]];
//        AudioButton *musicBt = (AudioButton *)[self.view viewWithTag:1];
//        [musicBt startSpin];
        //下载完存储目录
        [request setDownloadDestinationPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[_name MD5Hash]]]];
        //临时存储目录
        [request setTemporaryFileDownloadPath:[webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[_name MD5Hash]]]];
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
//            [musicBt stopSpin];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setDouble:total forKey:@"file_length"];
            Recordull += size;//Recordull全局变量，记录已下载的文件的大小
            if (!isPlay&&Recordull > 400000) {
                isPlay = !isPlay;
                [self playVideo];
            }
        }];
        //断点续载
        [request setAllowResumeForFileDownloads:YES];
        [request startAsynchronous];
        videoRequest = request;
    }
}
- (void)playVideo{
    MPMoviePlayerViewController *playerViewController =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:12345/%@.mp4",[_name MD5Hash]]]];
    [[NSNotificationCenter defaultCenter] addObserver:_delegate selector:@selector(videoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

    [_delegate presentMoviePlayerViewControllerAnimated:playerViewController];
}

- (void)videoFinish
{
    if (videoRequest) {
        isPlay = !isPlay;
        [videoRequest clearDelegatesAndCancel];
        videoRequest = nil;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }

}


@end
