//
//  KGBaseNavController.m
//  iOSKugou
//
//  Created by Jason on 15/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGBaseNavController.h"

@interface KGBaseNavController ()

@end

@implementation KGBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return false;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
