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
    UIImage *accountSettingImg = [UIImage imageNamed:@"account_setting_kugou"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:accountSettingImg]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
