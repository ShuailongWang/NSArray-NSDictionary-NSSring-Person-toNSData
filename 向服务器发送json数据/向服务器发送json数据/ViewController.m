//
//  ViewController.m
//  向服务器发送json数据
//
//  Created by czbk on 16/7/14.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 序列化  :把数据转换成二进制
 反序列化 :把二进制转换成数据
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //MARK: 1,字符串,
//    NSString *jsonStr = @"{\"name\":\"laoWang\",\"age\":\"20\"}";
//    //序列化
//    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    [self postWithData:data];
    
    //MARK: 2,字典
//    NSDictionary *dict = @{@"name":@"zhangSan",@"age":@"20"};
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
//    [self postWithData:data];
    
    //MARK: 3,数组
    NSDictionary *dict1 = @{@"name":@"xiaoMing",@"age":@"29"};
    NSDictionary *dict2 = @{@"name":@"laoWang",@"age":@"20"};
    NSArray *array = @[dict1,dict2];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:NULL];
    [self postWithData:data];
}

-(void)postWithData:(NSData*)data{
    //服务器地址
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/post/postjson.php"];
    
    //请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //请求方式
    request.HTTPMethod = @"POST";
    
    //设置请求体
    request.HTTPBody = data;
    
    //发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //
        if(nil == connectionError){
            //这块,我知道服务器返回的是字符串,所以我用字符串接受
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",str);
        }else{
            NSLog(@"%@",connectionError);
        }
    }];
}

@end
