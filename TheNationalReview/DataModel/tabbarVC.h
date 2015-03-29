//
//  tabbarVC.h
//  大众点评框架
//
//  Created by 骆冬宇 on 15/3/28.
//  Copyright (c) 2015年 骆冬宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tabbarVC : UITabBarController
- (UIViewController *)controllerWithController:(NSString *)controller title:(NSString *)title image:(NSString *)imageName andSelectImage:(NSString *)selectImage;
@end
