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

@property (nonatomic,strong) KGHelloKugou *kg;

@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,strong) UILabel *dynamicLabel;
@end

@implementation KGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;    
    [self.view addSubview:self.mainScrollView];
    
    [self welcomeAnimate];
}

- (void)welcomeAnimate {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    [self compatibleWithLaunchView:launchView];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    [launchView addSubview:self.dynamicLabel];
    [mainWindow addSubview:launchView];
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
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

#pragma mark - Utils
- (NSAttributedString *)matchWithRegex:(NSString *)regex
                               content:(NSString *)text
                                 attrs:(NSDictionary *)attrs{
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:text];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    for (int i = 0; i < text.length; ++i) {
        NSString *tmp = [text substringWithRange:NSMakeRange(i, 1)];
        if ([pred evaluateWithObject:tmp]) {
            [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(i, 1)];
            [hogan addAttributes:attrs range:NSMakeRange(i, 1)];
        }
    }
    return hogan;
}

#pragma mark - 懒加载
- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KGScreenW, KGScreenH)];
        _mainScrollView.backgroundColor = KGRGBWhite;
    }
    return _mainScrollView;
}

- (UILabel *)dynamicLabel {
    if (_dynamicLabel == nil) {
        _dynamicLabel = [[UILabel alloc] init];
        NSString *labelContent = [NSString stringWithFormat:@"本周听歌%@,超过%@%%的人",@"100",@"35"];
        NSAttributedString *attrsText = [self matchWithRegex:@"[0-9]" content:labelContent attrs:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _dynamicLabel.attributedText = attrsText;
        [_dynamicLabel sizeToFit];
        _dynamicLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5,[UIScreen mainScreen].bounds.size.height - 100);
    }
    return _dynamicLabel;
}

#pragma mark - 其它
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
