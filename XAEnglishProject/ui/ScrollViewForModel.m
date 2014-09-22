//
//  ScrollViewForModel.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-31.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "ScrollViewForModel.h"
#import "ModelCell.h"

@implementation ScrollViewForModel
{
    NSArray *array;
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
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"ModelCell" bundle:nil] forCellWithReuseIdentifier:@"ModelCell"];

}
- (void)insertIntoData:(NSDictionary *)dict
{
    array = dict[@"pic_array"];
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [array count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModelCell" forIndexPath:indexPath];
    NSDictionary *dict = array[indexPath.row];
    [cell.modelImageView setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image == nil) {
            return ;
        }
        cell.modelImageView.image = image;
    }];
    cell.modelTitleLabel.text = dict[@"desc"];
    
    cell.rightButtom.hidden = YES;
    cell.selectButton.hidden = YES;
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(326, 200);
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
