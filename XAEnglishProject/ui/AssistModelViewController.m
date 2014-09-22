//
//  AssistModelViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-11.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "AssistModelViewController.h"
#import "ModelCell.h"

@interface AssistModelViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,ModelCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (IBAction)finishButtonClick:(id)sender;
@property (nonatomic, strong) NSMutableArray *addArray;


@end

@implementation AssistModelViewController
{
    int postSuccess;
    int finishPost;
}

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
    postSuccess = 0;
    finishPost = 0;
    self.addArray = [[NSMutableArray alloc] init];

    [self.collectionView registerNib:[UINib nibWithNibName:@"ModelCell" bundle:nil] forCellWithReuseIdentifier:@"ModelCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self modelArrayRequest];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModelCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectButton.hidden = NO;
    cell.rightButtom.hidden = NO;
    [cell insertIntoData:self.dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(329, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)cellSelectedOrNot:(BOOL)state modelId:(NSString *)modelId
{
    if (state) {
        [self.addArray removeObject:modelId];
    }
    else {
        [self.addArray addObject:modelId];
        
    }
}


- (void)modelArrayRequest
{
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/module?type=1&book=1&client_id=%@",HOST,self.clientId] delegate:self finishMethod:@"finishMethod:" failMethod:@"failMethod:"];
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

- (IBAction)finishButtonClick:(id)sender {
    for (NSString *modelId in self.addArray) {
        UrlRequest *request = [[UrlRequest alloc] init];
        [request urlRequestWithPostUrl:[NSString stringWithFormat:@"%@/api/module/%@",HOST,modelId] delegate:self dict:@{@"client_id": self.clientId} finishMethod:@"finishAddMethod:" failMethod:@"failAddMethod:"];
    }
}

- (void)finishAddMethod:(NSData *)data
{
    postSuccess ++;
    finishPost ++;
    if (postSuccess == [self.addArray count]) {
        [self.navigationController popViewControllerAnimated:YES];

    }

}


- (void)failAddMethod:(NSError *)error
{
    finishPost ++;
    if (postSuccess != [self.addArray count] && finishPost == [self.addArray count]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络有问题请重试";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    

}

@end
