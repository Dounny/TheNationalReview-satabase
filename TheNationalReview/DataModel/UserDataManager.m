//
//  UserDataManager.m
//  TheNationalReview
//
//  Created by qianfeng on 15/3/28.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "UserDataManager.h"
#import "UserData.h"

@implementation UserDataManager
- (instancetype)init {
    if (self = [super init]) {
        _userData = [[UserData alloc] init];
    }
    
    return self;
}
@end
