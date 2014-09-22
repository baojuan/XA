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
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    __weak UIImageView *weakSelfImageView = self.imageView;
    [self.imageView setImageWithURL:[NSURL URLWithString:dict[@"pic_array"][0][@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image == nil) {
            return ;
        }
        weakSelfImageView.image = image;
        CGRect rect = weakSelfImageView.frame;
        rect.size.width = 1000;
        rect.size.height = image.size.height / image.size.width *rect.size.width;
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
