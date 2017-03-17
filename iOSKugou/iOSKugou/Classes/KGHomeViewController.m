 //
//  KGHomeViewController.m
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGHomeViewController.h"
#import "KGHelloKugou.h"
#import "KGThemeButton.h"
#import "PlayBarViewContainer.h"

@interface KGHomeViewController ()

@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,strong) UIButton *settingBtn;

@property (nonatomic,strong) UIScrollView *containerScrollView;
@property (nonatomic,strong) UIScrollView *listenScrollView;

@property (nonatomic,strong) KGThemeButton *listenBtn;
@property (nonatomic,strong) KGThemeButton *watchBtn;
@property (nonatomic,strong) KGThemeButton *singBtn;

@property (nonatomic,strong) NSArray <KGThemeButton *> *btns;
@end

@implementation KGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;    
    [self.view addSubview:self.mainScrollView];
    
    [self.navigationController.view addSubview:[self settingBtn]];
    
    _listenBtn = [KGThemeButton new];
    _watchBtn = [KGThemeButton new];
    _singBtn = [KGThemeButton new];
    
    NSArray *btns = @[_listenBtn,_watchBtn,_singBtn];
    CGFloat yDistance = 26;
    CGFloat bWidth = 38;
    CGFloat divWidth = 31 * (KGScreenW / 375);
    // lrDistance + 1.5 * bWidth + divWidth = KGScreenW * 0.5 (中间那块居中)
    CGFloat lrDistance = KGScreenW * 0.5 - bWidth * 1.5 - divWidth;
    for (int i = 0; i < btns.count; ++i) {
        [btns[i] setFrame:CGRectMake(lrDistance + i * (divWidth + bWidth) , yDistance, bWidth, bWidth)];
    }
    
    _btns = btns;
    
    NSBundle *cBundle = [KGConfig sharedConfig].curThemeBundle;
    UIImage *tingImg = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"listen"]];
    UIImage *tingImgOn = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"listen_on"]];
    UIImage *watchImg = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"watch"]];
    UIImage *watchImgOn = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"watch_on"]];
    UIImage *singImg = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"sing"]];
    UIImage *singImgOn = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"sing_on"]];
    
    [_listenBtn setImage:tingImg forState:UIControlStateNormal];
    [_listenBtn setImage:tingImgOn forState:UIControlStateSelected];
    _listenBtn.selected = true;
    [_watchBtn setImage:watchImg forState:UIControlStateNormal];
    [_watchBtn setImage:watchImgOn forState:UIControlStateSelected];
    [_singBtn setImage:singImg forState:UIControlStateNormal];
    [_singBtn setImage:singImgOn forState:UIControlStateSelected];
    
    [self.navigationController.view addSubview:_listenBtn];
    [self.navigationController.view addSubview:_watchBtn];
    [self.navigationController.view addSubview:_singBtn];
    
    [_listenBtn addTarget:self action:@selector(enjoyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_watchBtn addTarget:self action:@selector(enjoyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_singBtn addTarget:self action:@selector(enjoyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 两个滚动条
    _listenScrollView = [[UIScrollView alloc] initWithFrame:[self mainScrollView].bounds];
    UIImage *listenBgImg = [UIImage imageNamed:[cBundle pathForImageResourceWithName:@"home_listen_bg_one"]];
    UIImageView *listenBgImgView = [[UIImageView alloc] initWithImage:listenBgImg];
    listenBgImgView.w = KGScreenW;
    listenBgImgView.h = _listenScrollView.h;
    [_listenScrollView addSubview:listenBgImgView];
    [_mainScrollView addSubview:_listenScrollView];
    
    CGFloat proprotion = KGScreenW / 320;
    // 480 - 64 = 416 底部总高度为416
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 149 * proprotion, KGScreenW, KGScreenH - 149 * proprotion - KGNavH)];
    bottomView.backgroundColor = KGRGBWhite;
    
    [_listenScrollView addSubview:bottomView];
    
    // 播放器
    PlayBarViewContainer *playBar = [[PlayBarViewContainer alloc] initWithFrame:CGRectMake(0, KGScreenH - KGPlayBarH - KGNavH, KGScreenW, KGPlayBarH)];
    

    
    [self.view addSubview:playBar];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - 事件

- (void)enjoyClick:(KGThemeButton *)sender {
    for (KGThemeButton *b in _btns) {
        if (b == sender) {
            sender.selected = true;
        }else {
            b.selected = false;
        }
    }
    //
}

#pragma mark - 懒加载
// 这个显示的有问题,
- (UIView *)settingBtn {
    if (_settingBtn == nil) {
        
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.frame = CGRectMake(20, 29, 32, 32);
        NSString *userctPath = [[KGConfig sharedConfig].curThemeBundle pathForImageResourceWithName:@"userct_on"];
        UIImage *userctImg = [UIImage imageWithContentsOfFile:userctPath];
        [_settingBtn setImage:userctImg forState:UIControlStateNormal];
        
        // 与button同级的还有3个元素
        // UIImageView KGThemeImageView KGMusicHomeRedPoint
        
    }
    return _settingBtn;
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
