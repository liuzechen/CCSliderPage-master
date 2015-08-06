//
//  CCContentViewController.m
//  CCSliderPage
//
//  Created by v－ling on 15/7/17.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "CCContentViewController.h"

@interface CCContentViewController ()

@end

@implementation CCContentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (_delegate && [_delegate respondsToSelector:@selector(viewController:pageIndex:)]) {
        [_delegate viewController:self pageIndex:self.pageIndex];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
