//
//  firstPageViewController.m
//  StartUpDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "firstPageViewController.h"
#import "NewsTableViewCell.h"
#import "News.h"

#define SectionHeaderHeight 40.0

@interface firstPageViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView     *_tableView;
    NSMutableArray  *_news;
}

@end

@implementation firstPageViewController

#pragma mark - ViewController-life
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Blog";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self initData];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}

- (void)initData{
    //    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeList" ofType:@"plist"]];
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"]];
    _news = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [_news addObject:[News newsWithDictionary:dic]];
    }
}

#pragma mark - UITableViewCell delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"news";
    NewsTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell=[[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    News *news = _news[indexPath.row];
    cell.news = news;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", @(indexPath.section), @(indexPath.row)];
    return cell;
}

#pragma mark - UITableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}// 设置每行行高

// 设置Header的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"新鲜速递 · 资讯活动";
}

// 设置Header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SectionHeaderHeight;
}

// 自定义Header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, kScreenWidth, 20);
    //    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1];
    //    label.shadowColor = [UIColor grayColor];
    //    label.shadowOffset = CGSizeMake(-1.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SectionHeaderHeight)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, SectionHeaderHeight, kScreenWidth, 1)];    // 分割线
    line.backgroundColor = [UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:line];
    [view addSubview:label];
    
    return view;
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
