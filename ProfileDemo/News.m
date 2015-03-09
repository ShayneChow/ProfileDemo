//
//  News.m
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "News.h"

@implementation News

#pragma mark 根据字典初始化新闻对象
-(News *)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.newsImage = dic[@"image"];
        self.newsTitle = dic[@"title"];
        self.newsDate  = dic[@"date"];
        self.newsDesc  = dic[@"desc"];
        self.newsURL   = dic[@"url"];
    }
    return self;
}

#pragma mark 初始化新闻对象（静态方法）
+(News *)newsWithDictionary:(NSDictionary *)dic{
    News *news = [[News alloc] initWithDictionary:dic];
    return news;
}

@end
