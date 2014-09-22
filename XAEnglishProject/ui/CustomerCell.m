//
//  CustomerCell.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "CustomerCell.h"

static NSInteger const baseTag = 100;


@implementation CustomerCell

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
    self.icon.layer.cornerRadius = 15;
    self.icon.layer.masksToBounds = YES;
}

- (void)insertIntoData:(NSDictionary *)dict
{
    [self.icon setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@"log_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image == nil) {
            return ;
        }
        self.icon.image = image;
    }];
    
    self.phoneLabel.text = dict[@"phone"];
    if ([dict[@"sex"] intValue] == 0) {
        self.sexImageView.image = [UIImage imageNamed:@"sex_m"];
    }
    else {
        self.sexImageView.image = [UIImage imageNamed:@"sex_f"];
    }
    self.nameLabel.text = dict[@"name"];
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    CGRect rect = self.sexImageView.frame;
    CGSize size = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(100, self.nameLabel.frame.size.height)];
    rect.origin.x = self.nameLabel.frame.origin.x + size.width + 10;
    self.sexImageView.frame = rect;
}

- (void)setEditing:(BOOL)editing
{
    _deleteButton.hidden = !editing;
    _editing = !_editing;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)deleteButtonClick:(id)sender {
    [self.delegate itemDelete:(self.tag - baseTag)];
}
@end
