//
//  CustomerViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

//客户列表
#import "CustomerViewController.h"
#import "CustomerCell.h"
#import "AddCell.h"
#import "AddCustomerView.h"
#import "CustomerMainController.h"
static NSInteger const baseTag = 100;

@interface CustomerViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,CustomerCellDelegate,UIAlertViewDelegate,AddCustomerViewDelegate>
- (IBAction)addNavigationButtonClick:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNavigationButton;
- (IBAction)editButtonClick:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CustomerViewController
{
    NSDictionary *deleteDict;
    NSDictionary *pushDict;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomerCell" bundle:nil] forCellWithReuseIdentifier:@"CustomerCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AddCell" bundle:nil] forCellWithReuseIdentifier:@"AddCell"];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self customerArrayRequest];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 22;
    return [_dataArray count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_dataArray count]) {//indexPath.row == [_dataArray count]
        AddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddCell" forIndexPath:indexPath];
        return cell;
    }
    CustomerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomerCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell insertIntoData:self.dataArray[indexPath.row]];
    cell.tag = baseTag + indexPath.row;
    cell.editing = self.editing;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(325, 89);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_dataArray count]) {
        [self addCustomer];
    }
    else {
        pushDict = _dataArray[indexPath.row];
        
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"CustomerMainController" sender:self];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
}

- (void)addCustomer
{
    AddCustomerView *addCustomerView = [[[NSBundle mainBundle] loadNibNamed:@"AddCustomerView" owner:self options:nil] lastObject];
    addCustomerView.delegate = self;
    [self.tabBarController.view addSubview:addCustomerView];
}

- (void)addCustomerSuccess
{
    [self customerArrayRequest];
}

- (void)itemDelete:(NSInteger)modelIndex
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除用户" message:@"确定要删除该用户？\n删除该用户将导致该用户的数据被删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alertView.tag = baseTag + modelIndex;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDictionary *dict = [_dataArray objectAtIndex:(alertView.tag - baseTag)];
        deleteDict = dict;
        [self deleteUser:dict[@"id"]];
    }
}

- (void)deleteUser:(NSString *)clientId
{
    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithDeleteUrl:[NSString stringWithFormat:@"%@/api/user/client/%@",HOST,clientId] delegate:self finishMethod:@"deleteFinished:" failMethod:@"deleteFail:"];
}

- (void)deleteFinished:(NSData *)data
{
    [_dataArray removeObject:deleteDict];
    [self.collectionView reloadData];

}

- (void)deleteFail:(NSError *)error
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"删除失败";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"完成";
        self.editing = YES;
        [self.collectionView reloadData];
    }
    else {
        sender.title = @"编辑";
        self.editing = NO;
        [self.collectionView reloadData];
    }
}
- (IBAction)addNavigationButtonClick:(UIBarButtonItem *)sender {
    [self addCustomer];
}

- (void)customerArrayRequest
{
    NSString *saler_id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"saler_info"] objectForKey:@"id"];

    UrlRequest *request = [[UrlRequest alloc] init];
    [request urlRequestWithGetUrl:[NSString stringWithFormat:@"%@/api/user/client?saler_id=%@",HOST,saler_id] delegate:self finishMethod:@"finishMethod:" failMethod:@"failMethod:"];
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
    controller.title = [NSString stringWithFormat:@"%@的主页",pushDict[@"name"]];
    ((CustomerMainController *)controller).customerDict = pushDict;
    
}

@end
