//
//  KGHomeNavController.m
//  iOSKugou
//
//  Created by Jason on 16/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "KGHomeNavController.h"

@interface KGHomeNavController ()

@end

@implementation KGHomeNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 可能没有导航条,先暂时放一边。
   [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
