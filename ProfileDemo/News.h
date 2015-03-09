//
//  News.h
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

#pragma mark - 模型属性
@property (nonatomic, copy) NSString *newsImage;  // 资讯主图
@property (nonatomic, copy) NSString *newsTitle;  // 资讯标题
@property (nonatomic, copy) NSString *newsDesc;   // 资讯介绍
@property (nonatomic, copy) NSString *newsDate;   // 资讯日期
@property (nonatomic, copy) NSString *newsURL;   // 资讯消息介绍页面web链接

#pragma mark - 方法
#pragma mark 根据字典初始化新闻对象
-(News *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化新闻对象（静态方法）
+(News *)newsWithDictionary:(NSDictionary *)dic;

@end
