//
//  UrlRequest.h
//  MKProject
//
//  Created by baojuan on 14-6-27.
//  Copyright (c) 2014年 baojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlRequest : NSObject<NSXMLParserDelegate>
/**
 *  get 请求
 *
 *  @param url          url
 *  @param delegate     delegate
 *  @param finishMethod finishMethod
 *  @param failMethod   failMethod
 */

- (void)urlRequestWithGetUrl:(NSString *)url delegate:(id)delegate finishMethod:(NSString *)finishMethod failMethod:(NSString *)failMethod;
/**
 *  post 请求
 *
 *  @param url          url
 *  @param delegate     delegate
 *  @param dict         参数
 *  @param finishMethod finishMethod
 *  @param failMethod   failMethod
 */
- (void)urlRequestWithPostUrl:(NSString *)url delegate:(id)delegate dict:(NSDictionary *)dict finishMethod:(NSString *)finishMethod failMethod:(NSString *)failMethod;

/**
 *  delete 请求
 *
 *  @param url          url
 *  @param delegate     delegate
 *  @param finishMethod finishMethod
 *  @param failMethod   failMethod
 */

- (void)urlRequestWithDeleteUrl:(NSString *)url delegate:(id)delegate finishMethod:(NSString *)finishMethod failMethod:(NSString *)failMethod;


- (void)urlRequestWithGetUrl:(NSString *)url delegate:(id)delegate finishBlock:(void(^)(NSData * data))successBlock failBlock:(void(^)(void))failBlock;


- (void)urlRequestWithPostUrl:(NSString *)url delegate:(id)delegate dict:(NSDictionary *)dict finishBlock:(void(^)(NSData * data))successBlock failBlock:(void(^)(void))failBlock;

- (void)urlRequestWithPostForRecordUrl:(NSString *)url delegate:(id)delegate dict:(NSDictionary *)dict finishBlock:(void (^)(NSData *))successBlock failBlock:(void (^)(void))failBlock;

//put
- (void)urlRequestWithPutUrl:(NSString *)url delegate:(id)delegate data:(NSData *)data finishBlock:(void(^)(NSData * data))successBlock failBlock:(void(^)(void))failBlock;


@end
