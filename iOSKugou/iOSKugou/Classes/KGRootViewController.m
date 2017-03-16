//
//  KGRootViewController.m
//  iOSKugou
//
//  Created by Jason on 16/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

// 说明:简单移植 https://github.com/johnlui/SwiftSideslipLikeQQ
// 相应的blog地址为:https://lvwenhan.com/ios/445.html
// 源工程是Swift,为了让工程看上去纯粹些改成OC去实现

#import "KGRootViewController.h"
#import "KGHomeViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "KGSidebarViewController.h"
#import "KGHomeNavController.h"
#import "KGHelloKugou.h"

@interface KGRootViewController ()

// 因为酷狗目前看上去好像没有TabBar,所以先不用写

// 主界面点击手势，用于在菜单划出状态下点击主页后自动关闭菜单
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;

// 首页的 Navigation Bar 的提供者，是首页的容器
// cycript注入后,发现酷狗的rootViewController是UIViewController类型
// 用Reveal看也有不少的层是黑色的,所以实现原理应该和这个类似

@property (nonatomic,strong) UINavigationController *homeNavigationController;

// 首页主视图控制器
@property (nonatomic,strong) KGHomeViewController *homeViewController;

// 侧滑菜单视图的来源
@property (nonatomic,strong) KGSidebarViewController *sidebarViewController;

// helloKugou
@property (nonatomic,strong) KGHelloKugou *kg;

// 构造主视图，实现 UINavigationController.view 和 HomeViewController.view 一起缩放
@property (nonatomic,strong) UIView *mainView;

@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,assign) CGFloat fullDistance;
/// 比例
@property (nonatomic,assign) CGFloat proportion;
@property (nonatomic,assign) CGPoint centerOfLeftViewAtBeginning;
/// 左边的视图的比例
@property (nonatomic,assign) CGFloat proportionOfLeftView;
@property (nonatomic,assign) CGFloat distanceOfLeftView;

@property (nonatomic,strong) UILabel *dynamicLabel;

/// 遮罩视图
@property (nonatomic,strong) UIView *blackCover;

@end

@implementation KGRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _distance = 0;
    _fullDistance = 0.78;
    _proportion = 0.77;
    _proportionOfLeftView = 1;
    _distanceOfLeftView = 50;
    
    NSBundle *b = [KGConfig sharedConfig].curThemeBundle;
    NSString *sidebar = [b pathForImageResourceWithName:@"bg_sidebar"];
    UIImage *image = [UIImage imageWithContentsOfFile:sidebar];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = KGScreenBounds;
    [self.view addSubview:imageView];
    
    // 创建StoryBoard取出左侧的侧滑菜单视图
    _sidebarViewController = [[KGSidebarViewController alloc] init];
    if (KGScreenW > 320) {
        _proportionOfLeftView = KGScreenW / 320;
        _distanceOfLeftView += (KGScreenW - 320) * _fullDistance / 2;
    }
    _sidebarViewController.view.center = CGPointMake(_sidebarViewController.view.centerX - 50, _sidebarViewController.view.centerY);
    
    _sidebarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    
    // 动画参数初始化
    _centerOfLeftViewAtBeginning = _sidebarViewController.view.center;
    
    // 把侧滑菜单视图加入根容器
    [self.view addSubview:_sidebarViewController.view];
    
    // [self.view addSubview:[self blackCover]];
    
    [self.view addSubview:self.mainView];
    
    self.homeViewController = [[KGHomeViewController alloc] init];
    self.homeNavigationController = [[KGHomeNavController alloc] initWithRootViewController:self.homeViewController];
    
    [self.mainView addSubview:self.homeViewController.view];
    [self.mainView addSubview:self.homeNavigationController.view];
    
    // 分别指定 Navigation Bar 左右两侧按钮的事件 这个写法倒是第一次写
    self.homeNavigationController.navigationItem.leftBarButtonItem.action = @selector(showLeft);
    
    // 给主视图绑定 UIPanGestureRecognizer
    UIPanGestureRecognizer *panGesture = self.homeViewController.panGesture;
    [panGesture addTarget:self action:@selector(pan:)];
    
    [_mainView addGestureRecognizer:panGesture];
    
    // 生成点击收起菜单手势
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHome:)];
    
    [self welcomeAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件与动画
- (void)pan:(UIPanGestureRecognizer *)recongnizer {
    CGFloat x = [recongnizer translationInView:self.view].x;
    
    CGFloat trueDistance = _distance + x; // 实时距离
    CGFloat trueProportion = trueDistance / (KGScreenW * _fullDistance);
    
    // 控制单向滑动
    if (trueDistance < 0) {return;}
    
    // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        if (trueDistance > KGScreenW * (_proportion / 3)) {
            [self showLeft];
        }else if (trueDistance < KGScreenW * (_proportion / 3)) {
            [self showHome:nil];
        }
        return;
    }
    
    // 计算缩放比例
    CGFloat proportion = recongnizer.view.frame.origin.x >= 0 ? -1 : 1;
    proportion *= trueDistance / KGScreenW;
    proportion *= 1 - _proportion;
    proportion /= _fullDistance + _proportion / 2 - 0.5;
    proportion += 1;
    
    // 若比例已经达到最小，则不再继续动画
    if (proportion <= _proportion) {
        return;
    }
    
    // 执行视差特效 _blackCover
    // self.blackCover.alpha = (proportion - _proportion) / (1 - _proportion);
    
    // 执行平移和缩放动画
    recongnizer.view.center = CGPointMake(self.view.centerX + trueDistance, self.view.centerY);
//    recongnizer.view.transform = CGAffineTransformScale(recongnizer.view.transform, proportion, proportion);
    recongnizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    // 执行左视图动画
    CGFloat pro = 0.8 + (_proportionOfLeftView - 0.8) * trueDistance;
    _sidebarViewController.view.center = CGPointMake(_centerOfLeftViewAtBeginning.x + _distanceOfLeftView * trueProportion, _centerOfLeftViewAtBeginning.y - (_proportionOfLeftView - 1) * _sidebarViewController.view.frame.size.height * trueProportion / 2);
    // _sidebarViewController.view.transform = CGAffineTransformScale(_sidebarViewController.view.transform, pro, pro);
    _sidebarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
    
}

- (void)doTheAnimate:(CGFloat)proportion showWhat:(NSString *)showWhat {
    // 改变黑色遮罩层的透明度，实现视差效果
    // self.blackCover.alpha = showWhat == "home" ? 1 : 0
    
    [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:.2 options:UIViewAnimationOptionCurveLinear animations:^{
        
        // 移动首页中心
        self.mainView.center = CGPointMake(self.view.centerX + _distance, self.view.centerY);
        
        // 缩放首页
        // self.mainView.transform = CGAffineTransformScale(self.mainView.transform, proportion, proportion);
        self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        if ([showWhat isEqualToString:@"left"]) {
            // 移动左侧菜单的中心
            self.sidebarViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView, self.sidebarViewController.view.centerY);
            
            // 缩放左侧菜单
            self.sidebarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportionOfLeftView, self.proportionOfLeftView);
            
        }
        
        // 改变黑色遮罩层的透明度，实现视差效果
        // self.blackCover.alpha = [showWhat isEqualToString:@"home"] ? 1 : 0;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showLeft {
    // 给首页 加入 点击自动关闭侧滑菜单功能
    [self.mainView addGestureRecognizer:_tapGesture];
    // 计算距离，执行菜单自动滑动动画
    _distance = self.view.centerX * (_fullDistance * 2 + _proportion - 1);
    [self doTheAnimate:self.proportion showWhat:@"Left"];
    [_homeNavigationController popToRootViewControllerAnimated:true];
}

- (void)showHome:(UITapGestureRecognizer *)tap {
    // 从首页 删除 点击自动关闭侧滑菜单功能
    [_mainView removeGestureRecognizer:_tapGesture];
    // 计算距离，执行菜单自动滑动动画
    _distance = 0;
    [self doTheAnimate:1 showWhat:@"home"];
}

// 忽略,右边的侧滑,酷狗的功能不是这个
//- (void)showRight {
//    
//}

- (void)welcomeAnimate {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    [self compatibleWithLaunchView:launchView];
    
    [launchView addSubview:self.dynamicLabel];
    [_mainView addSubview:launchView];
    
    [UIView animateWithDuration:1.5f delay:0.5f options:UIViewAnimationOptionTransitionNone animations:^{
        
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
    
    // 播放欢迎声音
    if ([KGConfig sharedConfig].canHello) {
        KGHelloKugou *kg = [[KGHelloKugou alloc] init];
        _kg = kg;
        [kg hello];
    }
}

- (void)compatibleWithLaunchView:(UIView *)launchView {
    UIImageView *imgView = [launchView viewWithTag:99];
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        UIImageView *addImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage-568h"]];
        addImgView.frame = [UIScreen mainScreen].bounds;
        [launchView addSubview:addImgView];
        [imgView removeFromSuperview];
    }else if ([UIScreen mainScreen].bounds.size.width == 414) {
        UIImageView *addImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage-800-Portrait-736h"]];
        addImgView.frame = [UIScreen mainScreen].bounds;
        [launchView addSubview:addImgView];
        [imgView removeFromSuperview];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 懒加载
- (UILabel *)dynamicLabel {
    if (_dynamicLabel == nil) {
        _dynamicLabel = [[UILabel alloc] init];
        // 先静态的写
        NSString *labelContent = [NSString stringWithFormat:@"本周听歌%@,超过%@%%的人",@"100",@"35"];
        NSAttributedString *attrsText = [JAUtils matchWithRegex:@"[0-9]" content:labelContent attrs:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _dynamicLabel.attributedText = attrsText;
        [_dynamicLabel sizeToFit];
        _dynamicLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5,[UIScreen mainScreen].bounds.size.height - 100);
    }
    return _dynamicLabel;
}

//- (UIView *)blackCover {
//    if (_blackCover == nil) {
//        _blackCover = [[UIView alloc] initWithFrame:CGRectOffset(self.view.frame, 0, 0)];
//        _blackCover.backgroundColor = KGRGBBlack;
//    }
//    return _blackCover;
//}

- (UIView *)mainView {
    if (_mainView == nil) {
        _mainView = [[UIView alloc] initWithFrame:self.view.frame];
    }
    return _mainView;
}

@end
