//
//  RequestManager.m
//  JuXinReview
//
//  Created by WangZhipeng on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworkActivityIndicatorManager.h>
//#import "FileModel.h"
@implementation FileModel

+ (instancetype)fileWithName:(NSString *)name
                        data:(NSData *)data
                    mimeType:(NSString *)mimeType
                    filename:(NSString *)filename {
    FileModel *file = [[self alloc] init];
    file.name = name;
    file.fileData = data;
    file.mimeType = mimeType;
    file.filename = filename;
    return file;
}

@end
@implementation RequestManager


+(AFHTTPSessionManager*)sharedHTTPSessionManager
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求参数设置
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    //返回参数设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"AppType"];
    [manager.requestSerializer setValue:@"AppStore" forHTTPHeaderField:@"Channel"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forHTTPHeaderField:@"Deviceid"];
    [manager.requestSerializer setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Version"];
    

    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = 30;
    
    return manager;
}


#pragma mark -- GET请求 --
+ (NSURLSessionTask *)getWithURLString:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
    
    NSURLSessionTask *session = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success( responseObject );
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"\nGET请求：Request success, URL: %@\n params:%@\n",
                  [self generateGETAbsoluteURL:URLString params:parameters],
                  parameters);
            failure(error);
        }
    }];
  
    return session;
}

#pragma mark -- POST请求 --
+ (NSURLSessionTask *)postWithURLString:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
    NSURLSessionTask *session = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                  [self generateGETAbsoluteURL:URLString params:parameters],
                  parameters,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n",
                  [self generateGETAbsoluteURL:URLString params:parameters],
                  parameters);
            failure(error);
        }
    }];
    
    
    return session;
}





#pragma mark -- POST/GET网络请求 --
+ (NSURLSessionTask *)requestWithURLString:(NSString *)URLString
                                parameters:(id)parameters
                                      type:(HttpRequestType)type
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
    NSURLSessionTask *session = nil;
    switch (type) {
        case HttpRequestTypeGet:
        {
            session = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"\nget请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters,responseObject);
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    NSLog(@"\nGET请求：Request success, URL: %@\n params:%@\n",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters);

                    failure(error);
                }
            }];
            
            
        }
            break;
        case HttpRequestTypePost:
        {
            session = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters,responseObject);
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters);
                    failure(error);
                }
            }];
            
            
            
        }
            break;
    }
    
    
    
    return session;
}

#pragma mark -- 上传图片 --
+ (NSURLSessionTask *)uploadWithURLString:(NSString *)URLString
                               parameters:(id)parameters
                                 progress:(RequestProgress)progress
                              uploadParam:(FileModel *)uploadParam
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
    NSURLSessionTask *session = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.fileData name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress){
        if(progress){
            progress(uploadProgress);
        }
        
        }
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return session;
}

+(NSURLSessionDownloadTask *)downloadWithURLString:(NSString *)URLString
                                       savePathURL:(NSURL *)fileURL
                                          progress:(RequestProgress )progress
                                           success:(void (^)(id responseObject))success
                                           failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
    
    NSURL *urlpath = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }else{
            
            success(response);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;

}

// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}



@end
