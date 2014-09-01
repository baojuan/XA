//
//  UploadCell.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-18.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "UploadCell.h"
#import "RecordPlay.h"

@implementation UploadCell
{
    NSDictionary *recordInfo;
}

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
    recordInfo = dict;
    NSDictionary *clientDict = dict[@"client_info"];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:clientDict[@"image"]] placeholderImage:[UIImage imageNamed:@"log_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image == nil) {
            return ;
        }
        self.avatarImageView.image = image;
    }];
    
    if ([clientDict[@"sex"] intValue] == 0) {
        self.sexImageView.image = [UIImage imageNamed:@"sex_m"];
    }
    else {
        self.sexImageView.image = [UIImage imageNamed:@"sex_f"];
    }
    self.userNameLabel.text = clientDict[@"name"];
    [self layoutSubviews];
}


- (void)layoutSubviews
{
    CGRect rect = self.sexImageView.frame;
    CGSize size = [self.userNameLabel.text sizeWithFont:self.userNameLabel.font constrainedToSize:CGSizeMake(100, self.userNameLabel.frame.size.height)];
    rect.origin.x = self.userNameLabel.frame.origin.x + size.width + 10;
    self.sexImageView.frame = rect;
}


- (IBAction)rightButtonClick:(UIButton *)sender {
    if (sender) {
        [self.delegate deleteToUploadArray:recordInfo];
    }
    else {
        [self.delegate addToUploadArray:recordInfo];
    }
    sender.selected = !sender.selected;
}
- (IBAction)uploadButtonClick:(UIButton *)sender {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获得存储路径，
    NSString *documentDirectory = [paths objectAtIndex:0];//获得路径的第0个元素
    NSString *fullPath = [documentDirectory stringByAppendingPathComponent:recordInfo[@"record"]];//在第0个元素中添加txt文本
    
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:fullPath];
        
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithPostForRecordUrl:[NSString stringWithFormat:@"%@/api/record",HOST] delegate:self dict:@{@"saler_id": [NSString stringWithFormat:@"%d",[recordInfo[@"saler_id"] integerValue]],@"client_id":recordInfo[@"client_info"][@"id"],@"record_data":data} finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.delegate deleteDict:recordInfo];
    } failBlock:^{
        ;
    }];
    
    
}

- (void)setIsDelete:(BOOL)isDelete
{
    if (isDelete) {
        self.deleteButton.hidden = NO;
    }
    else {
        self.deleteButton.hidden = YES;
    }
    
}

- (void)setUploadAll:(BOOL)uploadAll
{
    _uploadAll = uploadAll;
    if (uploadAll) {
        self.backView.frame = CGRectMake(30, self.backView.frame.origin.y, self.backView.frame.size.width, self.backView.frame.size.height);
        self.uploadButton.hidden = YES;
    }
    else {
        self.backView.frame = CGRectMake(0, self.backView.frame.origin.y, self.backView.frame.size.width, self.backView.frame.size.height);
        self.uploadButton.hidden = NO;
    }
}

- (IBAction)deleteButtonClick:(id)sender {
    [self.delegate deleteDict:recordInfo];
}

- (IBAction)playButtonClick:(UIButton *)sender {
    if ([recordInfo objectForKey:@"media_url"]) {
        [[RecordPlay share] playWithName:recordInfo[@"media_url"]];
    }
    else {
        [[RecordPlay share] playWithName:recordInfo[@"record"]];

    }
    
}
@end
