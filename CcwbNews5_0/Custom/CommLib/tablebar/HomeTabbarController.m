//
//  HomeTabbarController.m
//  reersale
//
//  Created by xyy520 on 15-2-1.
//  Copyright (c) 2015年 谢 毅. All rights reserved.
//

#import "HomeTabbarController.h"
#import "Header.h"
@interface HomeTabbarController ()

@end

@implementation HomeTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [[UITabBar appearance] setTintColor:COLORNOW(234, 172, 0)];
//    [[UITabBar appearance] setBarTintColor:COLORNOW(224, 236, 243)];
//    [[UITabBar appearance] setSelectionIndicatorImage:LOADIMAGE(@"abc", @"png")];

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    DLog(@"asdfasdfasdfasdf123123123");
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
