//
//  PersonalNavigationViewController.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-5.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "PersonalNavigationViewController.h"

@interface PersonalNavigationViewController ()

@end

@implementation PersonalNavigationViewController

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
    UIImage *img = [UIImage imageNamed:@"tab2"];
    UIImage *img_selected = [UIImage imageNamed:@"tab2_S"];
    // 设置图片 渲染 模式
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置图片 渲染 模式
    img_selected = [img_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 构造方法生成 UITabBarItem
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:img selectedImage:img_selected];
    item.imageInsets = UIEdgeInsetsMake(0, -5, -10, -5);
    // 设置当前控制器的 tabBarItem属性
    self.tabBarItem = item;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
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
