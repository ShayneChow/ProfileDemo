//
//  UserInfoViewController.m
//  ProfileDemo
//
//  Created by ChowShayne on 15/3/18.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIKit+AFNetworking.h"

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

#pragma mark - ViewController-life
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人信息";
        self.view.backgroundColor = [UIColor brownColor];
        NSLog(@"个人信息页初始化");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadImage];
}

- (void)loadImage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;    // 自适应大小
    
    NSURL *url = [NSURL URLWithString:@"http://shaynechow.github.io/images/lee/lee03.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"icon"];
    __weak UIImageView *weakImageView = imageView;
    [weakImageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request,
                                             NSHTTPURLResponse *response,
                                             UIImage *image) {
                                        weakImageView.image = image;
                                       [weakImageView setNeedsLayout];
                                   }
                                   failure:nil
     ];
    
    [self.view addSubview:imageView];
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
