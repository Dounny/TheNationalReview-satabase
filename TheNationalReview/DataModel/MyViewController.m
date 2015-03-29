//
//  MyViewController.m
//  大众点评框架
//
//  Created by 骆冬宇 on 15/3/28.
//  Copyright (c) 2015年 骆冬宇. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的";
    //UIBarButtonItem *rightBarBtnItem = [UIBarButtonItem alloc] initWithBarButtonSystemItem: target:<#(id)#> action:<#(SEL)#>
    
//    UIView *view = [[UIView alloc] init];
//    view.frame =
//    UIBarButtonItem *item = [UIBarButtonItem alloc] initWithCustomView:
    UIBarButtonItem *helpItem = [[UIBarButtonItem alloc] initWithTitle:@"帮助" style:UIBarButtonItemStyleDone target:self action:@selector(click_help)];
    
    self.navigationItem.rightBarButtonItem = helpItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
