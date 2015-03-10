//
//  PageDetailViewController.m
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/10.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "PageDetailViewController.h"

#define webViewWidth [UIScreen mainScreen].bounds.size.width // 获取屏幕宽度
#define webViewHeight [UIScreen mainScreen].bounds.size.height// 定义WebView的高度

@interface PageDetailViewController ()

@end

@implementation PageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"详 情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubView];
    [self setSubView];
}

#pragma mark 初始化视图
- (void)initSubView{
    // 初始化 titleLabel
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;  // 居中
    _titleLabel.numberOfLines = 0;    // 自动换行
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:_titleLabel];
    
    // 初始化 dateLabel
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textAlignment = NSTextAlignmentCenter;  // 居中
    _dateLabel.textColor = [UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_dateLabel];
    
    // 初始化 contentText
    _contentText = [[UILabel alloc] init];
    _contentText.numberOfLines = 0;    // 自动换行
    _contentText.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_contentText];
    
    // 初始化 UIWebView
    _detailWebView = [[UIWebView alloc] init];
    [self.view addSubview:_detailWebView];
}

#pragma mark 设置视图frame
- (void)setSubView{
    // 设置标题 label 的frame
    CGFloat titleLabelX = 0, titleLabelY = 64;
    CGRect titleLabelRect = CGRectMake(titleLabelX, titleLabelY, webViewWidth, 30.0);
    _titleLabel.frame = titleLabelRect;
    _titleLabel.text = _detailTitle;
    
    // 设置日期 label 的frame
    CGFloat dateLabelX = 0, dateLabelY = titleLabelY+30.0;
    CGRect dateLabelRect = CGRectMake(dateLabelX, dateLabelY, webViewWidth, 20.0);
    _dateLabel.frame = dateLabelRect;
    _dateLabel.text = _detailDate;
    
    // 设置 contentText 的frame
    CGFloat contentTextX = 0, contentTextY = dateLabelY+10.0;
    CGRect contentTextRect = CGRectMake(contentTextX, contentTextY, webViewWidth, 100.0);
    _contentText.frame = contentTextRect;
    _contentText.text = _detailDesc;
    
    // 设置 UIWebView 的frame
    CGFloat webViewX = 0, webViewY = contentTextY+100.0;
    CGRect webViewRect = CGRectMake(webViewX, webViewY, webViewWidth, webViewHeight);
    _detailWebView.frame = webViewRect;
    [_detailWebView loadRequest:[NSURLRequest requestWithURL:_detailURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
