//
//  thirdPageViewController.m
//  StartUpDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "thirdPageViewController.h"
#import "UserInfoViewController.h"
#import "UIKit+AFNetworking.h"

#define kHeaderViewHeight 120.0
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kPadding 15.0

@interface thirdPageViewController (){
    UITableView     *_tableView;
    UIView          *_headerView;
}

@end

@implementation thirdPageViewController

#pragma mark - ViewController-life
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"About";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = [self configHeaderView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 初始化表头视图
- (UIView *)configHeaderView{
//    __weak typeof(self) weakSelf = self;
    
    // 表头frame
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kHeaderViewHeight)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    // 视图内容部分与上部的分隔区域：20位
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    headerView.backgroundColor = _tableView.backgroundColor;
    [_headerView addSubview:headerView];
    
    // 头像 image
    UIImageView *userIconView = [[UIImageView alloc] initWithFrame:CGRectMake(kPadding, kPadding+20, 70, 70)];
    // 将 image 设置为圆形
    userIconView.layer.masksToBounds = YES;
    userIconView.layer.cornerRadius = userIconView.frame.size.width/2;
    userIconView.layer.borderWidth = 1.5;
    userIconView.layer.borderColor = headerView.backgroundColor.CGColor;
    userIconView.contentMode = UIViewContentModeScaleAspectFill; // 图片自适应填充模式
    
    //加载网络图片（同步加载，没有缓存，阻塞UI，实际开发中，应采用异步缓存加载）
//    NSURL *imageUrl = [NSURL URLWithString:@"http://shaynechow.github.io/images/aboutthisblog/about.jpg"];
//    UIImage *userIconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//    userIconView.image = userIconImage;
//    [userIconView setImage]
    
//    userIconView.image = [UIImage imageNamed:@"icon"];
    
    // 异步加载网络图片，采用 AFNetworking 库
    NSURL *url = [NSURL URLWithString:@"http://shaynechow.github.io/images/aboutthisblog/about.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"icon"];
    __weak UIImageView *weakImageView = userIconView;
    [weakImageView setImageWithURLRequest:request
                         placeholderImage:placeholderImage
                                  success:^(NSURLRequest *request,
                                            NSHTTPURLResponse *response,
                                            UIImage *image) {
                                      weakImageView.image = image;
                                      [weakImageView setNeedsLayout];// setNeedsLayout:标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
                                  }
                                  failure:nil
     ];
    
    [_headerView addSubview:userIconView];
    
    // 昵称 label
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(125, kPadding+20, kScreen_Width-125-35, 30)];
//    userName.backgroundColor = [UIColor purpleColor];
    userName.font = [UIFont boldSystemFontOfSize:16];
//    userName.textColor = [UIColor blackColor];
    userName.text = @"骨哥";
    [_headerView addSubview:userName];
    
    // 性别 image
    UIImageView *userSexIconView = [[UIImageView alloc] initWithFrame:CGRectMake(100, kPadding+20+5, 20, 20)];
//    userSexIconView.backgroundColor = [UIColor blueColor];
    [userSexIconView setImage:[UIImage imageNamed:@"sex_man_icon"]];
    [_headerView addSubview:userSexIconView];
    
    // 生日 label
    UILabel *userBirthday = [[UILabel alloc] initWithFrame:CGRectMake(100, kPadding+20+30, kScreen_Width-100-35, 20)];
//    userBirthday.backgroundColor = [UIColor redColor];
    userBirthday.font = [UIFont systemFontOfSize:14];
    userBirthday.textColor = [UIColor grayColor];
    userBirthday.text = @"生日：3月 6日";
    [_headerView addSubview:userBirthday];
    
    // 签名 label
    UILabel *sloganLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, kHeaderViewHeight-kPadding-20, CGRectGetWidth(userBirthday.frame), 20)];
//    sloganLabel.backgroundColor = [UIColor brownColor];
    sloganLabel.font = [UIFont systemFontOfSize:12];
    sloganLabel.textColor = [UIColor grayColor];
    sloganLabel.text = @"这个家伙很懒，什么都没留下...";

    [_headerView addSubview:sloganLabel];
    
    // 详情箭头 image
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_info_arrow_left"]];
    [arrowImageView setCenter:CGPointMake(kScreen_Width-CGRectGetWidth(arrowImageView.frame)/2-10, 20+15+70/2)];
    [_headerView addSubview:arrowImageView];
    
    // 表头视图响应点击事件
    _headerView.userInteractionEnabled=YES;
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    
    //给self.view添加一个手势监测；
    
    [_headerView addGestureRecognizer:singleRecognizer];
    
    return _headerView;
}

- (void)SingleTap{
    NSLog(@"点击用户信息设置，跳转到信息设置界面。");
    
    UserInfoViewController *userInfoSettingView = [[UserInfoViewController alloc] init];
    [self.navigationController pushViewController:userInfoSettingView animated:YES];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 0;
    
    if (section == 0) {
        row = 3;
    }else if (section == 1){
        row = 1;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifier";
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;// 为每个 cell 添加跳转箭头
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.imageView.image = [UIImage imageNamed:@"heart"];
                    cell.textLabel.text = @"我的收藏（2）";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.imageView.image = [UIImage imageNamed:@"share"];
                    cell.textLabel.text = @"我的分享（1）";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    cell.imageView.image = [UIImage imageNamed:@"usd"];
                    cell.textLabel.text = @"我的卡券（2）";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            break;
            
        default:
            cell.imageView.image = [UIImage imageNamed:@"setting"];
            cell.textLabel.text = @"设置";
            break;
    }
    
    return cell;
}

#pragma mark - TableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}// 脚部的高度，不设置或设为0时默认为固定高度0,最后一行脚部为行距44

// 自定义 section 的头部 view，此处为灰色的分隔部分
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
//    headerView.backgroundColor = [UIColor colorWithHexString:@"0xe5e5e5"];
//    if (section == 0) {
//        [headerView addLineUp:YES andDown:NO andColor:tableView.separatorColor];
//    }
//    return headerView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}// 点击 cell 时的动画

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
