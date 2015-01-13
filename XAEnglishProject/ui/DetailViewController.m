//
//  DetailViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-12.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "DetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ImageForModel.h"
#import "ScrollViewForModel.h"
#import "VideoForModel.h"
#import "PriceForModel.h"


@interface DetailViewController ()<AVAudioRecorderDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *beforeButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)beforeButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButtonClick;
- (IBAction)playButtonClick:(id)sender;
- (IBAction)nextButtonClick:(id)sender;

@end

@implementation DetailViewController
{
    NSURL *recordedTmpFile;
    AVAudioRecorder *recorder;
    NSMutableArray *viewArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        viewArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dict = self.modelArray[self.selectIndex];
    self.navigationItem.title = dict[@"name"];
    self.scrollView.delegate = self;
    [self addViews];
    
    
    
    
    
    
    
    //Instanciate an instance of the AVAudioSession object.
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    //Setup the audioSession for playback and record.
    //We could just use record and then switch it to playback leter, but
    //since we are going to do both lets set it up once.
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    //Activate the session
    [audioSession setActive:YES error: nil];
    
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self videoFinished:nil];
    if ([recorder isRecording]) {
        [recorder stop];
    }
    recorder = nil;
    recordedTmpFile = nil;
}

- (void)addViews
{
    CGFloat width = MAX(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView setContentSize:SIZE(width * [self.modelArray count], 609)];

    for (int i = 0; i < [self.modelArray count]; i ++) {
        NSDictionary *dict = self.modelArray[i];
        if ([[dict objectForKey:@"content_type"] isEqualToString:@"single_pic"]) {
            ImageForModel *imageView = [[[NSBundle mainBundle] loadNibNamed:@"ImageForPad" owner:self options:nil] lastObject];
            [viewArray addObject:imageView];
            imageView.frame = RECT(width * (i) + (width - imageView.frame.size.width) / 2.0, 0, imageView.frame.size.width, imageView.frame.size.height);
            UrlRequest *request = [[UrlRequest alloc] init];

            [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/module/%@",HOST,dict[@"id"]] delegate:self finishBlock:^(NSData *data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                [imageView insertIntoData:dict[@"data"]];

            } failBlock:^{
                ;
            }];
            [self.scrollView addSubview:imageView];
        }
        if ([[dict objectForKey:@"content_type"] isEqualToString:@"multi_pic"]) {
            ScrollViewForModel *scrollView = [[[NSBundle mainBundle] loadNibNamed:@"ScrollViewForModel" owner:self options:nil] lastObject];
            [viewArray addObject:scrollView];
            scrollView.frame = RECT(width * (i) + (width - scrollView.frame.size.width) / 2.0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            UrlRequest *request = [[UrlRequest alloc] init];

            [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/module/%@",HOST,dict[@"id"]] delegate:self finishBlock:^(NSData *data){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                scrollView.frame = RECT(self.scrollView.contentSize.width * (i) + (self.scrollView.contentSize.width - 1000) / 2.0, 10, 1000, 609);
                [scrollView insertIntoData:dict[@"data"]];
            } failBlock:^{
                ;
            }];
            [self.scrollView addSubview:scrollView];
        }
        if ([[dict objectForKey:@"content_type"] isEqualToString:@"video_text"]) {
            VideoForModel *videoView = [[[NSBundle mainBundle] loadNibNamed:@"VideoForModel" owner:self options:nil] lastObject];
            [viewArray addObject:videoView];
            videoView.frame = RECT(width * (i) + (width - videoView.frame.size.width) / 2.0, 0, videoView.frame.size.width, videoView.frame.size.height);
            UrlRequest *request = [[UrlRequest alloc] init];

            [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/module/%@",HOST,dict[@"id"]] delegate:self finishBlock:^(NSData *data){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                [videoView insertIntoData:dict[@"data"] delegate:self];
            } failBlock:^{
                ;
            }];
            [self.scrollView addSubview:videoView];
        }
        if ([[dict objectForKey:@"content_type"] isEqualToString:@"price"]) {
            PriceForModel *priceView = [[PriceForModel alloc] init];
            [viewArray addObject:priceView];
            priceView.frame = RECT(width * (i) + (width - priceView.frame.size.width) / 2.0, 100, priceView.frame.size.width, priceView.frame.size.height);
            UrlRequest *request = [[UrlRequest alloc] init];
            
            [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/price",HOST] delegate:self finishBlock:^(NSData *data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                [priceView insertIntoData:dict[@"data"]];
                
            } failBlock:^{
                ;
            }];
            [self.scrollView addSubview:priceView];
        }

    }
    self.scrollView.contentOffset = POINT(width * self.selectIndex, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSDictionary *dict = self.modelArray[(int)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)];
    self.title = dict[@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)beforeButtonClick:(id)sender {
    if (self.scrollView.contentOffset.x == 0) {
        return;
    }
    CGFloat width = MAX(self.scrollView.frame.size.width, self.scrollView.frame.size.height);

    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x - width, self.scrollView.contentOffset.y);
}

- (IBAction)playButtonClick:(UIButton *)sender {
    
    
    if (sender.selected) {
        NSLog(@"pause");
        [recorder pause];
    }
    else {
        NSLog(@"begin");
        if (recorder) {
            [recorder record];
        }
        else {
            NSString *saler_id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"] objectForKey:@"id"];
            CGFloat date = [NSDate timeIntervalSinceReferenceDate];
            NSString *recordName = [NSString stringWithFormat: @"%.0f.%@", date * 1000.0, @"caf"];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"recordArray"]];
            [array addObject:@{@"saler_id": saler_id,@"client_info":self.clientInfo,@"record":recordName,@"create_time":[NSString stringWithFormat: @"%.0f", date]}];
            
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"recordArray"];
            
            //Now that we have our settings we are going to instanciate an instance of our recorder instance.
            //Generate a temp file for use by the recording.
            //This sample was one I found online and seems to be a good choice for making a tmp file that
            //will not overwrite an existing one.
            //I know this is a mess of collapsed things into 1 call.  I can break it out if need be.
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获得存储路径，
            NSString *documentDirectory = [paths objectAtIndex:0];//获得路径的第0个元素
            NSString *fullPath = [documentDirectory stringByAppendingPathComponent:recordName];//在第0个元素中添加txt文本
            
            
            
            
            recordedTmpFile = [NSURL fileURLWithPath:fullPath];
            NSLog(@"Using File called: %@",recordedTmpFile);
            //Setup the recorder to use this file and record to it.
            NSError *error;
            recorder = [[AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:nil error:&error];
            NSLog(@"error:%@",error);
            //Use the recorder to start the recording.
            //Im not sure why we set the delegate to self yet.
            //Found this in antother example, but Im fuzzy on this still.
            [recorder setDelegate:self];
            //We call this to start the recording process and initialize
            //the subsstems so that when we actually say "record" it starts right away.
            [recorder prepareToRecord];
            //Start the actual Recording
            [recorder record];
        }
       

    }
    sender.selected = !sender.selected;
}

- (IBAction)nextButtonClick:(id)sender {
    if (self.scrollView.contentOffset.x + SCREEN_HEIGHT == self
        .scrollView.contentSize.width) {
        return;
    }
    CGFloat width = MAX(self.scrollView.frame.size.width, self.scrollView.frame.size.height);

    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + width, self.scrollView.contentOffset.y);

}


- (void)videoFinished:(NSNotification *)notification
{
    int i = (int)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if (i < [viewArray count]) {
        VideoForModel *model = ((VideoForModel *)(viewArray[i])) ;
        [model.play videoFinish];
    }
    
}


@end
