//
//  CCPageViewController.h
//  CCSliderPage
//
//  Created by v－ling on 15/7/17.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPageViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray *contentViewControllers;

@end
