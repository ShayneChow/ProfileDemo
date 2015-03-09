//
//  NewsTableViewCell.m
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "News.h"

#define kPending 10.0
#define kImageWidth kRowHeight-20.0
#define kImageHeight kImageWidth
#define kTitleWidth kScreenWidth-kRowHeight-kPending-kDateWidth
#define kTitleHeight 20.0
#define kDescWidth kScreenWidth-kRowHeight-kPending
#define kDescHeight kRowHeight-kTitleHeight-2.5*kPending
#define kDateWidth 65.0
#define kDateHeight kTitleHeight

@interface NewsTableViewCell(){
    UIImageView *_newsImage;    //图片
    UILabel     *_newsTitle;    //标题
    UILabel     *_newsDesc;     //简介
    UILabel     *_newsDate;     //日期
}
@end

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

#pragma mark --初始化视图
- (void)initSubView{
    // 初始化新闻图片
    _newsImage = [[UIImageView alloc] init];
    [self addSubview:_newsImage];
    
    // 初始化新闻标题
    _newsTitle = [[UILabel alloc] init];
    _newsTitle.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:_newsTitle];
    
    // 初始化新闻简介
    _newsDesc = [[UILabel alloc] init];
    _newsDesc.font = [UIFont systemFontOfSize:14];
    _newsDesc.textColor = [UIColor grayColor];
    [self addSubview:_newsDesc];
    
    // 初始化新闻日期
    _newsDate = [[UILabel alloc] init];
    //    _newsDate.backgroundColor = [UIColor redColor];
    _newsDate.textColor = [UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1];
    _newsDate.font = [UIFont systemFontOfSize:12];
    [self addSubview:_newsDate];
}

#pragma mark --设置新闻News的frame
- (void)setNews:(News *)news{
    // 设置题图frame
    CGFloat newsImageX = kPending, newsImageY = kPending;
    CGRect newsImageRect = CGRectMake(newsImageX, newsImageY, kImageWidth, kImageHeight);
    _newsImage.image = [UIImage imageNamed:news.newsImage];
    _newsImage.frame = newsImageRect;
    
    // 设置标题frame
    CGFloat newsTitleX = kRowHeight, newsTitleY = kPending;
    CGRect newsTitleRect = CGRectMake(newsTitleX, newsTitleY, kTitleWidth, kTitleHeight);
    _newsTitle.text = news.newsTitle;
    _newsTitle.frame = newsTitleRect;
    
    // 设置简介frame
    CGFloat newsDescX = newsTitleX, newsDescY = newsTitleY + kTitleHeight + 0.5*kPending;
    CGRect newsDescRect = CGRectMake(newsDescX, newsDescY, kDescWidth, kDescHeight);
    _newsDesc.text = news.newsDesc;
    _newsDesc.numberOfLines = 0;    // 自动换行
    _newsDesc.frame = newsDescRect;
    
    // 设置日期frame
    CGFloat newsDateX = kScreenWidth -kDateWidth - kPending, newsDateY = newsTitleY;
    CGRect newsDateRect = CGRectMake(newsDateX, newsDateY, kDateWidth, kDateHeight);
    _newsDate.text = news.newsDate;
    _newsDate.frame = newsDateRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end