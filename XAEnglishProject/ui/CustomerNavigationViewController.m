//
//  CustomerNavigationViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "CustomerNavigationViewController.h"
#import "PersonalNavigationViewController.h"
@interface CustomerNavigationViewController ()

@end

@implementation CustomerNavigationViewController

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
    
    
    
    // UITabbarController里面的tabbarItem中的图片需要特殊API处理之后,才能正常显示
    UIImage *img = [UIImage imageNamed:@"tab1"];
    UIImage *img_selected = [UIImage imageNamed:@"tab1_S"];
    // 设置图片 渲染 模式
//    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置图片 渲染 模式
    img_selected = [img_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 构造方法生成 UITabBarItem
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:img selectedImage:img_selected];
    item.imageInsets = UIEdgeInsetsMake(0, -5, -10, -5);
    // 设置当前控制器的 tabBarItem属性
    self.tabBarItem = item;
    
    
    
    // 默认情况下,app运行之后,只执行第一个控制器的view did load方法,因此,要得到UITabBarController容器中所有的控制器,调用其自定义的一个方法,设置它们自己的tabbaritem样式
    
    // 先得到父容器UITabBarController,有了它,就有了所有的控制器实例的引用
    UITabBarController *parentCtrl = (UITabBarController *)self.parentViewController;
    // 得到容器UITabBarController中所有的子控制器
    NSArray *children = [parentCtrl childViewControllers];
    // 调用对应的子控制器的 自定义方法,设置它们自己的tabbaritem样式
    PersonalNavigationViewController *nanaVC = (PersonalNavigationViewController *)[children objectAtIndex:1];
    [nanaVC viewDidLoad];
    
    self.tabBarController.selectedIndex = 0;
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

@end
