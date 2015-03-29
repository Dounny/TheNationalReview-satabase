//
//  LDYButton.m
//  block基本语法
//
//  Created by 骆冬宇 on 15/3/6.
//  Copyright (c) 2015年 骆冬宇. All rights reserved.
//

#import "LDYButton.h"
@interface LDYButton()
//要用copy
@property(nonatomic, copy)block myBlock;

@end

@implementation LDYButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//+ (LDYButton *)buttonWithFrame:(CGRect)frame backgroudColor:(UIColor *)backgroudColor titleColor:(UIColor *)titleColor type:(UIButtonType)type title:(NSString *)title target:(id)target andAction :(SEL)sel
//{
//    
//    LDYButton *btn = [UIButton buttonWithType:type];
//    btn.frame = frame;
//    btn.backgroundColor = backgroudColor;
//    
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitle:@"按钮" forState:UIControlStateNormal];
//    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
//    return btn;
//}

//利用block生成button对象
+ (LDYButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock
{
    LDYButton *btn = [LDYButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.myBlock = tempBlock;
    
    return btn;
}
- (void)buttonClick:(LDYButton *)button
{
    NSLog(@"这里是buttonClicked方法的内部");
    button.tag = 10;
    //触发按钮
    _myBlock(button);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
