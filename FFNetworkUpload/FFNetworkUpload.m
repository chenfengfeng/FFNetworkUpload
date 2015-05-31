//
//  FFNetworkUpload.m
//  FFNetworkUploadDemo
//
//  Created by 陈峰峰 on 15/5/31.
//  Copyright (c) 2015年 陈峰峰. All rights reserved.
//

#import "FFNetworkUpload.h"

@interface FFNetworkUpload()

@end

@implementation FFNetworkUpload

+(instancetype)networkUpload
{
    FFNetworkUpload *network= [[FFNetworkUpload alloc]init];
    return network;
}

-(void)updataVideoWithUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(NSArray *)arrImage withCompressionQuality:(CGFloat)compressionQuality
{
    //检查参数是否正确
    if (!url|| !arrImage) {
        NSLog(@"参数不完整");
        return;
    }
    if ([url rangeOfString:@"http://"].location == NSNotFound) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    //初始化
    NSString *hyphens = @"--";
    NSString *boundary = @"chenfengfeng";
    NSString *end = @"\r\n";
    //初始化数据
    NSMutableData *myRequestData1=[NSMutableData data];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //添加其他参数
    for(int i = 0;i < [keys count];i ++)
    {
        NSMutableString *body = [[NSMutableString alloc]init];
        [body appendString:hyphens];
        [body appendString:boundary];
        [body appendString:end];
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //添加字段名称
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"%@%@",key,end,end];
        
        //添加字段的值
        [body appendFormat:@"%@",[params objectForKey:key]];
        [body appendString:end];
        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"添加字段的值==%@",[params objectForKey:key]);
    }
    //添加图片资源
    for (int i = 0; i < arrImage.count; i++) {
        if (![arrImage[i] isKindOfClass:[UIImage class]]) {
            return;
        }
        //获取资源
        UIImage *image = arrImage[i];
        //得到图片的data
        NSData* data = UIImageJPEGRepresentation(image,compressionQuality);
        //所有字段的拼接都不能缺少，要保证格式正确
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        //要上传的文件名和key，服务器端接收
        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"file\";filename=\"file%u.png\"",i];
        [fileTitle appendString:end];
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:application/octet-stream%@",end]];
        [fileTitle appendString:end];
        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:data];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //拼接结束~~~
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData1 length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    //回调返回值
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            if ([self.delegate respondsToSelector:@selector(requestErrorFromServer:)]) {
                [self.delegate requestErrorFromServer:@"请求超时"]; //出现任何服务器端返回的错误，交给代理处理
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(finish)]) {
                [self.delegate finish];
            }
        }
        
    }];
    
}

@end
