//
//  RequestManager.h
//  JuXinReview
//
//  Created by WangZhipeng on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

//@class FileModel;


@interface FileModel : NSObject

/** 文件参数名(key) */
@property(nonatomic, copy) NSString *name;
/** 文件数据 */
@property(nonatomic, strong) NSData *fileData;
/** 文件类型 */
@property(nonatomic, copy) NSString *mimeType;
/** 文件名 */
@property(nonatomic, copy) NSString *filename;

+ (instancetype)fileWithName:(NSString *)name
                        data:(NSData *)data
                    mimeType:(NSString *)mimeType
                    filename:(NSString *)filename;
@end

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

@interface RequestManager : NSObject


/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */
typedef void (^RequestProgress)(NSProgress *progress);

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionTask *)getWithURLString:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionTask *)postWithURLString:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionTask *)requestWithURLString:(NSString *)URLString
                                parameters:(id)parameters
                                      type:(HttpRequestType)type
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionTask *)uploadWithURLString:(NSString *)URLString
                               parameters:(id)parameters
                                  progress:(RequestProgress)progress
                              uploadParam:(FileModel *)uploadParam
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;



/**
 *  下载文件
 *
 *  @param URLString 下载请求地址
 *  @param fileURL   文件保存地址
 *  @param progress  进度
 *  @param success   请求成功回调
 *  @param failure   请求失败回调
 *
 *  @return NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+(NSURLSessionDownloadTask *)downloadWithURLString:(NSString *)URLString
                                       savePathURL:(NSURL *)fileURL
                                          progress:(RequestProgress )progress
                                           success:(void (^)(id responseObject))success
                                           failure:(void (^)(NSError *error))failure;




@end

