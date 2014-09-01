//
//  MyRecordViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-18.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "MyRecordViewController.h"
#import "UploadCell.h"
#import "RecordPlay.h"

@interface MyRecordViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UploadCellDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (nonatomic, strong) NSMutableArray *uploadArray;
@property (nonatomic, strong) NSMutableArray *uploadedRecordArray;

@end

@implementation MyRecordViewController
{
    BOOL uploadAll;
    BOOL isDelete;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc] init];
    uploadAll = NO;
    isDelete = NO;
    _uploadArray = [[NSMutableArray alloc] init];
    _uploadedRecordArray = [[NSMutableArray alloc] init];
    NSString *saler_id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"] objectForKey:@"id"];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"recordArray"];
    for (NSDictionary *dict in array) {
        if ([dict[@"saler_id"] integerValue] == [saler_id integerValue]) {
            [_dataArray addObject:dict];
        }
    }
    [self requestRecordArray];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"UploadCell" bundle:nil] forCellWithReuseIdentifier:@"UploadCell"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[RecordPlay share] pause];
    [[NSUserDefaults standardUserDefaults] setObject:_dataArray forKey:@"recordArray"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.segmentController.selectedSegmentIndex == 0) {
        return [_dataArray count];

    }
    else {
        return [_uploadedRecordArray count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UploadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UploadCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.uploadAll = uploadAll;
    cell.isDelete = isDelete;
    if (self.segmentController.selectedSegmentIndex == 0) {
        cell.uploadButton.hidden = NO;

    }
    else {
        cell.uploadButton.hidden = YES;
    }
    [cell insertIntoData:_dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(325, 87);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deleteDict:(NSDictionary *)dict
{
    [_dataArray removeObject:dict];
    [self.collectionView reloadData];
}
- (IBAction)cancelButtonClick:(id)sender {
    [self allUploadButtonClick:self.allUploadButton];
}

- (IBAction)uploadButtonClick:(id)sender {
    
    for (NSDictionary *recordInfo in self.uploadArray) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获得存储路径，
        NSString *documentDirectory = [paths objectAtIndex:0];//获得路径的第0个元素
        NSString *fullPath = [documentDirectory stringByAppendingPathComponent:recordInfo[@"record"]];//在第0个元素中添加txt文本
        
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:fullPath];
        
        UrlRequest *request = [[UrlRequest alloc] init];
        [request urlRequestWithPostForRecordUrl:[NSString stringWithFormat:@"%@/api/record",HOST] delegate:self dict:@{@"saler_id": [NSString stringWithFormat:@"%d",[recordInfo[@"saler_id"] integerValue]],@"record_data":data,@"client_id":recordInfo[@"client_info"][@"id"]} finishBlock:^(NSData *data) {
            [self deleteDict:recordInfo];
        } failBlock:^{
            ;
        }];

    }
    [_uploadArray removeAllObjects];
    [self allUploadButtonClick:self.allUploadButton];

}
- (IBAction)allUploadButtonClick:(UIButton *)sender {
    if (sender.selected) {
        self.uploadButton.hidden = YES;
        self.cancelButton.hidden = YES;
        uploadAll = NO;
    }
    else {
        self.uploadButton.hidden = NO;
        self.cancelButton.hidden = NO;
        uploadAll = YES;
        
    }
    [self.collectionView reloadData];

    sender.selected = !sender.selected;
}
- (IBAction)selectSegment:(UISegmentedControl *)sender {
    [self.collectionView reloadData];
}

- (IBAction)editBarButtonClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"完成"]) {
        if (self.segmentController.selectedSegmentIndex == 0) {
            if (uploadAll) {
                self.uploadButton.hidden = NO;

                self.cancelButton.hidden = NO;
                self.allUploadButton.hidden = YES;
            }
            else {
                self.uploadButton.hidden = YES;
                
                self.cancelButton.hidden = YES;
                self.allUploadButton.hidden = NO;

            }
//            self.allDeleteButton.hidden = YES;
        }
        else {
            self.uploadButton.hidden = YES;
            self.cancelButton.hidden = YES;
            self.allUploadButton.hidden = YES;
//            self.allDeleteButton.hidden = NO;
        }
        sender.title = @"编辑";
        isDelete = NO;
    }
    else {
        self.uploadButton.hidden = YES;
        self.cancelButton.hidden = YES;
        self.allUploadButton.hidden = YES;
//        self.allDeleteButton.hidden = YES;
        sender.title = @"完成";
        isDelete = YES;
    }
    [self.collectionView reloadData];
}
- (IBAction)allDeleteButtonClick:(UIButton *)sender {
    
}

- (void)deleteToUploadArray:(NSDictionary *)dict{
    [self.uploadArray removeObject:dict];
}

- (void)addToUploadArray:(NSDictionary *)dict
{
    [self.uploadArray addObject:dict];
}

- (void)requestRecordArray
{
    NSString *saler_id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"] objectForKey:@"id"];

    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/record?saler_id=%@",HOST,saler_id] delegate:self finishBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [_uploadedRecordArray addObject:dict[@"data"]];
        [self.collectionView reloadData];
    } failBlock:^{
        ;
    }];
}

@end
