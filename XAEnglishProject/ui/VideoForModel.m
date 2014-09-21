//
//  VideoForModel.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-31.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "VideoForModel.h"
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
    [self.imageView setImageWithURL:[NSURL URLWithString:dict[@"cover_img"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        self.imageView.image = image;
    }];
    self.title1.text = dict[@"field_one"];
    self.title2.text = dict[@"field_two"];
    self.content.text = dict[@"content"];
    video = dict[@"video"];
    [self layoutSubviews];
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
