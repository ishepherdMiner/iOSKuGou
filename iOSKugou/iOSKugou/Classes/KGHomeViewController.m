//
//  KGHomeViewController.m
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGHomeViewController.h"
#import "KGHelloKugou.h"

@interface KGHomeViewController ()

@property (nonatomic,strong) UIScrollView *mainScrollView;

@end

@implementation KGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;    
    [self.view addSubview:self.mainScrollView];
    
    // 创建导航条的侧滑功能的按钮,遇到点问题。
//    UIImage *accountSettingImg = [UIImage imageNamed:@"account_setting_kugou"];
//    accountSettingImg = [accountSettingImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImageView *accountSettingImgView = [[UIImageView alloc] initWithImage:accountSettingImg];
//    accountSettingImgView.alpha = 1.0;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:accountSettingImgView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
}

#pragma mark - 懒加载
- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KGScreenW, KGScreenH)];
        _mainScrollView.backgroundColor = KGRGBWhite;
    }
    return _mainScrollView;
}

- (UIPanGestureRecognizer *)panGesture {
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] init];
    }
    return _panGesture;
}

#pragma mark - 其它
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
