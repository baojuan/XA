//
//  CustomerMainController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "CustomerMainController.h"
#import "ModelCell.h"
#import "AddModelCell.h"
#import "ModelListView.h"
#import "TopicModelViewController.h"
#import "AssistModelViewController.h"
#import "DetailViewController.h"
@interface CustomerMainController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@end

@implementation CustomerMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

    [self.collectionView registerNib:[UINib nibWithNibName:@"ModelCell" bundle:nil] forCellWithReuseIdentifier:@"ModelCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AddModelCell" bundle:nil] forCellWithReuseIdentifier:@"AddModelCell"];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self modelArrayRequest];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count]+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_dataArray count]) {//indexPath.row == [_dataArray count]
        AddModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddModelCell" forIndexPath:indexPath];
        return cell;
    }
    ModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModelCell" forIndexPath:indexPath];
    
    [cell insertIntoData:self.dataArray[indexPath.row]];
    cell.rightButtom.hidden = YES;
    cell.selectButton.hidden = YES;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(327, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_dataArray count]) {
        [self addModel];
    }
    else {
        self.selectIndexPath = indexPath;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"DetailViewController" sender:self];
    }
}
- (void)addModel
{
    ModelListView *modelListView = [[[NSBundle mainBundle] loadNibNamed:@"ModelListView" owner:self options:nil] lastObject];
    modelListView.delegate = self;
    [self.tabBarController.view addSubview:modelListView];
}

- (void)addTopicButtonClick
{
    [self performSegueWithIdentifier:@"TopicModelViewController" sender:self];

}

- (void)addAssistButtonClick
{
    [self performSegueWithIdentifier:@"AssistModelViewController" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)modelArrayRequest
{
    NSString *client_id = self.customerDict[@"id"];
    
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/module?client_id=%@",HOST,client_id] delegate:self finishMethod:@"finishMethod:" failMethod:@"failMethod:"];
}

- (void)finishMethod:(NSData *)data
{
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([dict[@"code"] intValue] == 0) {
        self.dataArray = dict[@"data"];
        [self.collectionView reloadData];
    }
}

- (void)failMethod:(NSError *)error
{
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *controller = segue.destinationViewController;
    if ([controller isKindOfClass:[TopicModelViewController class]]) {
        ((TopicModelViewController *) controller).clientId = [NSString stringWithFormat:@"%d",[self.customerDict[@"id"] integerValue]];
    }
    if ([controller isKindOfClass:[AssistModelViewController class]]) {
        ((AssistModelViewController *) controller).clientId = [NSString stringWithFormat:@"%d",[self.customerDict[@"id"] integerValue]];
    }
    if ([controller isKindOfClass:[DetailViewController class]]) {
        ((DetailViewController *) controller).modelArray = _dataArray;
        ((DetailViewController *) controller).selectIndex = self.selectIndexPath.row;
        ((DetailViewController *) controller).clientInfo = self.customerDict;

    }
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

@end
