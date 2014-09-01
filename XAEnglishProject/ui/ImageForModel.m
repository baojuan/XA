//
//  ImageForModel.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-31.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "ImageForModel.h"

@implementation ImageForModel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)insertIntoData:(NSDictionary *)dict
{
    __weak ImageForModel *weakSelf = self;

    __weak UIImageView *weakSelfImageView = self.imageView;
    [self.imageView setImageWithURL:[NSURL URLWithString:dict[@"cover_img"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        weakSelfImageView.image = image;
        CGRect rect = weakSelfImageView.frame;
        rect.size.height = image.size.height / image.size.width * rect.size.width;
        weakSelfImageView.frame = rect;
        self.contentSize = SIZE(rect.size.width, rect.size.height);
    }];
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
