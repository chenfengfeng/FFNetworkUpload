//
//  ViewController.m
//  FFNetworkUploadDemo
//
//  Created by 陈峰峰 on 15/5/31.
//  Copyright (c) 2015年 陈峰峰. All rights reserved.
//

#import "ViewController.h"
#import "FFNetworkUpload.h"

@interface ViewController ()<FFNetworkUploadDelegat>

@property (strong, nonatomic) NSArray *arrImage;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *juhua;

@property (weak, nonatomic) IBOutlet UITextField *url;

/**
 *  初始化FFNetworkUpload
 */
@property (nonatomic, strong) FFNetworkUpload *networkUpload;

@end

@implementation ViewController

-(NSArray *)arrImage
{
    if (_arrImage == nil) {
        _arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"01"],[UIImage imageNamed:@"02"],[UIImage imageNamed:@"03"],[UIImage imageNamed:@"04"],[UIImage imageNamed:@"05"],[UIImage imageNamed:@"06"], nil];
    }
    return _arrImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNetworkUpload];
}

- (IBAction)click_upload:(id)sender {
    [self.juhua startAnimating];
    [self.networkUpload updataVideoWithUrl:self.url.text withParams:nil withImage:self.arrImage withCompressionQuality:0.3];
}

#pragma mark - 初始化并且设置代理
-(void)initNetworkUpload
{
    self.networkUpload = [FFNetworkUpload networkUpload];
    self.networkUpload.delegate = self;
}

#pragma mark -代理方法
#pragma mak 上传失败
-(void)requestErrorFromServer:(NSString *)msg
{
    [self.juhua stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
#pragma mark 上传成功
-(void)finish
{
    [self.juhua stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}



@end
