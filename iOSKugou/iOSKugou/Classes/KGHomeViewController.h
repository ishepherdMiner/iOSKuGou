//
//  KGHomeViewController.h
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGThemeButton;

@interface KGHomeViewController : UIViewController
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic,strong,readonly) UIButton *settingBtn;

// 首页的听看唱的按钮
@property (nonatomic,strong,readonly) KGThemeButton *listenBtn;
@property (nonatomic,strong,readonly) KGThemeButton *watchBtn;
@property (nonatomic,strong,readonly) KGThemeButton *singBtn;

@end
