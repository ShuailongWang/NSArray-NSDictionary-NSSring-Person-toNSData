//
//  ViewController.m
//  向服务器发送数据-自定义对象
//
//  Created by czbk on 16/7/14.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建对象
    Person *per = [[Person alloc]init];
    per.name = @"laoWang";
    per.height = @"168";
    
    //kvc 私有成员变量赋值
    [per setValue:@(200) forKey:@"_weight"];
    
    //对象转换过为dci
    NSDictionary *dict = [per dictionaryWithValuesForKeys:@[@"name",@"height",@"_weight"]];
    
    //判断对象是否可以序列化
    if(![NSJSONSerialization isValidJSONObject:dict]){
        NSLog(@"这个对象不能进行json序列化");
    }
    
    //把字典转换过成二进制
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
    
    //调用方法
    [self postWith:data];
}


//向服务器发送数据
- (void)postWith:(NSData *)data
{
    // url
    NSURL *url = [NSURL URLWithString:@"http://localhost/post/postjson.php"];
    //可变请求
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    requestM.HTTPMethod = @"POST";
    
    //设置请求体
    requestM.HTTPBody = data;
    
    //发送请求
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {
            //解析json
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"str =%@",str);
        }else
        {
            NSLog(@"connectionError %@",connectionError);
        }
    }];
}

@end
