//
//  UtilClass.m
//  XAEnglishProject
//
//  Created by baojuan on 14-8-26.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "UtilClass.h"

@implementation UtilClass
//手机号码验证

+ (BOOL) validateMobile:(NSString *)mobile

{
    //手机号以13，15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

@end
