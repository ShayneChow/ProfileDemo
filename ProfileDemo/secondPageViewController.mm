//
//  secondPageViewController.m
//  StartUpDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "secondPageViewController.h"
#import "BMapKit.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@interface secondPageViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate>{
//    BMKMapManager* _mapManager;
    BMKMapView *_mapView;
    BMKPoiSearch *_searcher;
//    BMKPointAnnotation* pointAnnotation;
    int curPage;
}

@end

@implementation secondPageViewController

#pragma mark - ViewController-life
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Map";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _mapView.showMapScaleBar = YES; // 是否显示比例尺
//    _mapView.compassPosition = CGPointMake(10, 10);
    [self.view addSubview:_mapView];
    
    //初始化检索对象
    _searcher =[[BMKPoiSearch alloc]init];

    //发起检索
    curPage = 0;
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = curPage;
    option.pageCapacity = 10;
    option.location = CLLocationCoordinate2D{23.1409150000,113.3095210000}; // 定位广东省广州市越秀区环市东路坐标
    option.keyword = @"一袋轻奢";
    // 设置地图级别
    [_mapView setZoomLevel:18]; // 地图的放大级别
//    _mapView.isSelectedAnnotationViewFront = YES; // 设定是否总让选中的annotaion置于最前面, yes后地图不能双指旋转
    
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
            }
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen; // 设置大头针颜色
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        newAnnotationView.draggable = YES;// 可拖动
        newAnnotationView.image = [UIImage imageNamed:@"position"];
        
        return newAnnotationView;
    }else{
        //        这里使用自定义大头针
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.image = [UIImage imageNamed:@"nav_tweet_friend"];
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        return newAnnotationView;
    }
    return nil;
}

// 标注弹出窗口点击事件
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    NSLog(@"paopaoclick");
    UIAlertView *alertViewPao = [[UIAlertView alloc] initWithTitle:@"点击气泡标注框" message:@"这是一个定位标注气泡" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil];
    [alertViewPao show];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [_mapView viewWillAppear];
    
    _mapView.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
    _searcher.delegate = self;
    
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    
    _mapView.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
}


- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    NSLog(@"地图加载完毕加载完毕"); //这里的代理方法我就不一一展示了，具体使用情况请自己调整
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
