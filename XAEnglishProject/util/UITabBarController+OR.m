//
//  UITabBarController+OR.m
//  XAEnglishProject
//
//  Created by baojuan on 14-9-9.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "UITabBarController+OR.h"

@implementation UITabBarController (OR)
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (void)viewDidLoad
{

}

@end
