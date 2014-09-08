//
//  UrlRequest.m
//  MKProject
//
//  Created by baojuan on 14-6-27.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import "UrlRequest.h"
#import "NSString+PRPURLAdditions.h"
#import "AFHTTPRequestOperation.h"

#define DATA(string) ([string dataUsingEncoding:NSUTF8StringEncoding])



@implementation UrlRequest

- (void)urlRequestWithGetUrl:(NSString *)url delegate:(id)delegate finishMethod:(NSString *)finishMethod failMethod:(NSString *)failMethod
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] != 200)
        {
            if ([delegate respondsToSelector:NSSelectorFromString(failMethod)]) {
                [delegate performSelector:NSSelectorFromString(failMethod) withObject:Nil];
            }
        }
        if ([delegate respondsToSelector:NSSelectorFromString(finishMethod)]) {
            [delegate performSelector:NSSelectorFromString(finishMethod) withObject:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([delegate respondsToSelector:NSSelectorFromString(failMethod)]) {
            [delegate performSelector:NSSelectorFromString(failMethod) withObject:error];
        }
    }];
    [operation start];
}

- (void)urlRequestWithPostUrl:(NSString *)url delegate:(id)delegate dict:(NSDictionary *)dict finishMethod:(NSString *)finishMethod failMethod:(NSString *)failMethod
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableString *post = [[NSMutableString alloc]init];
    for (NSString *paramKey in dict)
    {
        if ([paramKey length] > 0)
        {
            NSStringEncoding enc=NSUTF8StringEncoding;
            NSString *value = [dict objectForKey:paramKey];
            NSString *encodedValue = [value prp_URLEncodedFormStringUsingEncoding:enc];
            NSString *paramFormat = @"%@=%@&";
            [post appendFormat:paramFormat,paramKey,encodedValue];
//            [post appendFormat:paramFormat,paramKey,value];
        }

    }
    [post deleteCharactersInRange:NSMakeRange([post length] - 1, 1)];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([delegate respondsToSelector:NSSelectorFromString(finishMethod)]) {
            [delegate performSelector:NSSelectorFromString(finishMethod) withObject:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([delegate respondsToSelector:NSSelectorFromString(failMethod)]) {
            [delegate performSelector:NSSelectorFromString(failMethod) withObject:error];
        }
    }];
    [operation start];
}


- (void)urlRequestWithDeleteUrl:(NSString *)url delegate:(id)delegate finishMethod:(NSString *)finishMethod failMethod:(NSString *)failMethod
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"DELETE"];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] != 200)
        {
            if ([delegate respondsToSelector:NSSelectorFromString(failMethod)]) {
                [delegate performSelector:NSSelectorFromString(failMethod) withObject:Nil];
            }
        }
        if ([delegate respondsToSelector:NSSelectorFromString(finishMethod)]) {
            [delegate performSelector:NSSelectorFromString(finishMethod) withObject:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([delegate respondsToSelector:NSSelectorFromString(failMethod)]) {
            [delegate performSelector:NSSelectorFromString(failMethod) withObject:error];
        }
    }];
    [operation start];

}




- (void)urlRequestWithGetUrl:(NSString *)url delegate:(id)delegate finishBlock:(void (^)(NSData *data))successBlock failBlock:(void (^)(void))failBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] == 200)
        {
            if (successBlock) {
                successBlock(operation.responseData);
            }
        }
        else {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failBlock) {
            failBlock();
        }
    }];
    [operation start];
}


- (void)urlRequestWithPostUrl:(NSString *)url delegate:(id)delegate dict:(NSDictionary *)dict finishBlock:(void (^)(NSData *))successBlock failBlock:(void (^)(void))failBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableString *post = [[NSMutableString alloc]init];
    for (NSString *paramKey in dict)
    {
        if ([paramKey length] > 0)
        {
            NSStringEncoding enc=NSUTF8StringEncoding;
            NSString *value = [dict objectForKey:paramKey];
//            NSString *encodedValue = [value prp_URLEncodedFormStringUsingEncoding:enc];
            NSString *paramFormat = @"%@=%@&";
//            [post appendFormat:paramFormat,paramKey,encodedValue];
            [post appendFormat:paramFormat,paramKey,value];
        }
        
    }
    [post deleteCharactersInRange:NSMakeRange([post length] - 1, 1)];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] == 200)
        {
            if (successBlock) {
                successBlock(operation.responseData);
            }
        }
        else {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        if (failBlock) {
            failBlock();
        }
    }];
    [operation start];

}


- (void)urlRequestWithPostForRecordUrl:(NSString *)url delegate:(id)delegate dict:(NSDictionary *)dict finishBlock:(void (^)(NSData *))successBlock failBlock:(void (^)(void))failBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
//    NSMutableString *post = [[NSMutableString alloc]init];
//    for (NSString *paramKey in dict)
//    {
//        if ([paramKey length] > 0)
//        {
//            NSStringEncoding enc=NSUTF8StringEncoding;
//            NSString *value = [dict objectForKey:paramKey];
//            //            NSString *encodedValue = [value prp_URLEncodedFormStringUsingEncoding:enc];
//            NSString *paramFormat = @"%@=%@&";
//            //            [post appendFormat:paramFormat,paramKey,encodedValue];
//            [post appendFormat:paramFormat,paramKey,value];
//        }
//        
//    }
//    [post deleteCharactersInRange:NSMakeRange([post length] - 1, 1)];
//    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];

    
    
    NSString *boundary = @"AaB03x";
    NSString *beginTag = [NSString stringWithFormat:@"--%@\r\n", boundary];
    NSString *endTag = [NSString stringWithFormat:@"--%@--", boundary];
    
    
    // 设置请求头信息-数据类型
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    
    // 拼接请求体
    NSMutableData *data = [NSMutableData data];
    
    for (NSString *key in dict) {
        id value = [dict objectForKey:key];
        
        if (![value isKindOfClass:NSData.class]) {
            // 普通参数-username
            // 普通参数开始的一个标记
            [data appendData:DATA(beginTag)];
            
            // 参数描述
            NSString *disposition =[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n", key];
            [data appendData:DATA(disposition)];
            
            // 参数值
            NSString *valueString = [NSString stringWithFormat:@"\r\n%@\r\n", value];
            [data appendData:DATA(valueString)];
        }
        else
        {
            // 文件参数-file
            // 文件参数开始的一个标记
            [data appendData:DATA(beginTag)];
            // 文件参数描述
            NSString *disposition = [NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"1.caf\"\r\n", key];
            [data appendData:DATA(disposition)];
            
            // 文件的MINETYPE
            [data appendData:DATA(@"Content-Type:audio/mpeg\r\n")];
            
            
            // 文件内容
            [data appendData:DATA(@"\r\n")];
            
            
            [data appendData:value];
            [data appendData:DATA(@"\r\n")];
            
            // 参数结束的标识
            [data appendData:DATA(endTag)];
        }
    }
    
    // 设置请求体
    request.HTTPBody = data;
    
    
    
    
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] == 200)
        {
            if (successBlock) {
                successBlock(operation.responseData);
            }
        }
        else {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        if (failBlock) {
            failBlock();
        }
    }];
    [operation start];
    
}


- (void)urlRequestWithPutUrl:(NSString *)url delegate:(id)delegate data:(NSData *)data finishBlock:(void(^)(NSData * data))successBlock failBlock:(void(^)(void))failBlock;
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([operation.response statusCode] == 200)
        {
            if (successBlock) {
                successBlock(operation.responseData);
            }
        }
        else {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        if (failBlock) {
            failBlock();
        }
    }];
    [operation start];
}




@end
