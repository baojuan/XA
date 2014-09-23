//
//  VideoForModel.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-31.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "VideoForModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@implementation VideoForModel
{
    NSString *video;
    UIViewController *_delegate;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
}

- (void)insertIntoData:(NSDictionary *)dict delegate:(UIViewController *)delegate
{
    _delegate = delegate;
    NSArray *array = dict[@"pic_array"];
    if ([array count] > 0) {
        [self.imageView setImageWithURL:[NSURL URLWithString:dict[@"pic_array"][0][@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            self.imageView.image = image;
        }];
    }
    
    
    
    
    
    self.title1.text = dict[@"field_one"];
    self.title2.text = dict[@"field_two"];
    self.content.text = dict[@"content"];
    video = dict[@"video"];
//    self.imageView.image = [self getVideoPreViewImage:video];
//    MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:video]];
//    [mp requestThumbnailImagesAtTimes:@[[NSNumber numberWithFloat:0]] timeOption:MPMovieTimeOptionExact];
//    
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieThumbnailLoadComplete:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    

    
    
    [self layoutSubviews];
}


-(void)movieThumbnailLoadComplete:(NSNotification*)notification{
    
    NSLog(@"userInfo:");
    
    NSDictionary *userInfo = [notification userInfo];
    
    
    
    NSNumber *timecode =[userInfo objectForKey: @"MPMoviePlayerThumbnailTimeKey"];
    
    UIImage *image =[userInfo objectForKey: @"MPMoviePlayerThumbnailImageKey"];
    
    
    
}

- (UIImage*) getVideoPreViewImage:(NSString *)videoPath
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoPath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}




- (void)tapGes
{
    self.play = [[VideoPlay alloc] initWithDelegate:_delegate name:self.title1.text url:video];
    [self.play videoPlay];
}

- (void)layoutSubviews
{
    CGRect rect = self.content.frame;
    CGSize size = [self.content.text sizeWithFont:self.content.font constrainedToSize:CGSizeMake(self.content.frame.size.width, 1000)];
    rect.size.height = size.height;
    self.content.frame = rect;
    
    self.contentSize = SIZE(self.frame.size.width, self.content.frame.size.height + self.content.frame.origin.y + 20);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
