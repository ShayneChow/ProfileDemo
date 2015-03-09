//
//  NewsTableViewCell.h
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRowHeight 100.0
#define kScreenWidth [UIScreen mainScreen].applicationFrame.size.width

@class News;

@interface NewsTableViewCell : UITableViewCell

#pragma mark 新闻对象
@property (nonatomic,strong) News *news;

@end
