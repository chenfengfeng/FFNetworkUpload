# FFNetworkUpload
专门用于多图片上传的工具

## 简介
 * 用于表单上传的程序可以直接上传多个文件或者多个图片
 * 使用非常简单，只需要把需要上传的文件放入一个array里面，并且声明格式，就可以直接上传到指定的服务器接口
 
##使用说明Demo
```
//初始化FFNetworkUpload
	@property (nonatomic, strong) FFNetworkUpload *networkUpload;

//初始化并且设置代理
	self.networkUpload = [FFNetworkUpload networkUpload];
    
//执行方法
/**
 *  图片上传调用方法
 *
 *  @param url                请求的URL地址
 *  @param params             额外的参数
 *  @param arrImage           图片集合数组
 *  @param compressionQuality 压缩比例
 */
-(void)updataVideoWithUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(NSArray *)arrImage withCompressionQuality:(CGFloat)compressionQuality;
```

##代理的实现
```
先让代理所属控制器
self.networkUpload.delegate = self;
之后调用代理方法，一共两个代理方法，一个上传成功和一个上传失败的代理方法
//上传失败代理
-(void)requestErrorFromServer:(NSString *)msg;
//上传成功回调
-(void)finish;
```