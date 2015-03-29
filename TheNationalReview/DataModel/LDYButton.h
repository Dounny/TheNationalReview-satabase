//
//  LDYButton.h
//  block基本语法
//
//  Created by 骆冬宇 on 15/3/6.
//  Copyright (c) 2015年 骆冬宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDYButton;
typedef void (^block)(LDYButton *button);
@interface LDYButton : UIButton

+ (LDYButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock;
@end
