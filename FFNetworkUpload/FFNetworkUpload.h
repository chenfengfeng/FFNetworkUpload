//
//  FFNetworkUpload.h
//  FFNetworkUploadDemo
//
//  Created by 陈峰峰 on 15/5/31.
//  Copyright (c) 2015年 陈峰峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FFNetworkUploadDelegat <NSObject>

@optional
/**
 *  上传失败代理
 *
 *  @param msg 返回失败数据
 */
-(void)requestErrorFromServer:(NSString *)msg;

/**
 *  上传成功回调
 */
-(void)finish;

@end

@interface FFNetworkUpload : NSObject
/**
 *  代理
 */
@property (weak, nonatomic) id<FFNetworkUploadDelegat> delegate;
/**
 *  初始化
 *
 *  @return 返回FFNetworkUpload
 */
+(instancetype)networkUpload;
/**
 *  图片上传调用方法
 *
 *  @param url                请求的URL地址
 *  @param params             额外的参数
 *  @param arrImage           图片集合数组
 *  @param compressionQuality 压缩比例
 */
-(void)updataVideoWithUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(NSArray *)arrImage withCompressionQuality:(CGFloat)compressionQuality;


@end
