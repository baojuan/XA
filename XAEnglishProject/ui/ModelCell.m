//
//  ModelCell.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "ModelCell.h"

@implementation ModelCell
{
    NSString *modelId;
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
    self.modelImageView.layer.cornerRadius = 25;
    self.modelImageView.layer.masksToBounds = YES;
    self.rightButtom.layer.cornerRadius = 12;
    self.rightButtom.layer.masksToBounds = YES;
    self.deleteButton.hidden = YES;
}

- (void)prepareForReuse
{
    self.deleteButton.hidden = YES;
}
- (IBAction)deleteButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cellDeleteModel:)]) {
        [self.delegate cellDeleteModel:modelId];
    }
}

- (void)insertIntoData:(NSDictionary *)dict
{
    modelId = dict[@"id"];
    [self.modelImageView setImageWithURL:[NSURL URLWithString:dict[@"cover_img"]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image == nil) {
            return ;
        }
        self.modelImageView.image = image;
    }];
    self.modelTitleLabel.text = dict[@"name"];
}

- (IBAction)rightButtonClick:(UIButton *)sender {
    [self.delegate cellSelectedOrNot:self.rightButtom.selected modelId:modelId];
    self.rightButtom.selected = !self.rightButtom.selected;
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

@end
