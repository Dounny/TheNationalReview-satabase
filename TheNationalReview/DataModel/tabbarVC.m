//
//  tabbarVC.m
//  大众点评框架
//
//  Created by 骆冬宇 on 15/3/28.
//  Copyright (c) 2015年 骆冬宇. All rights reserved.
//

#import "tabbarVC.h"

@interface tabbarVC ()

@end

@implementation tabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIViewController *)controllerWithController:(NSString *)controller title:(NSString *)title image:(NSString *)imageName andSelectImage:(NSString *)selectImage
{
    Class viewController = NSClassFromString(controller);
    UIViewController *VC = [[viewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    
    //[nav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    VC.title = title;
    VC.tabBarItem.title = nil;
    VC.navigationItem.title = nil;
    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.viewControllers];
    
    [tempArr addObject:nav];
    
    self.viewControllers = tempArr;
    
    return VC;
    
}



@end
