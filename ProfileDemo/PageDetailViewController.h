//
//  PageDetailViewController.h
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/10.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageDetailViewController : UIViewController

@property (nonatomic, retain) NSURL *detailURL;
@property (nonatomic, copy) NSString *detailImage;  // 分享主图
@property (nonatomic, copy) NSString *detailTitle;  // 分享主图
@property (nonatomic, copy) NSString *detailDesc;  // 分享标题
@property (nonatomic, copy) NSString *detailDate;  // 分享日期
@property (nonatomic, retain) UIWebView *detailWebView;// 作为显示的主内容
@property (nonatomic, retain) UILabel *titleLabel;// 显示的title
@property (nonatomic, retain) UILabel *dateLabel;// 显示的date
@property (nonatomic, retain) UILabel *contentText;// 显示的主内容
@property (nonatomic, retain) UIImageView *imageView;// 显示的主内容

@end
