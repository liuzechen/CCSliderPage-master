//
//  CCContentViewController.h
//  CCSliderPage
//
//  Created by v－ling on 15/7/17.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCContentViewControllerDelegate;

@interface CCContentViewController : UIViewController

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, weak) id<CCContentViewControllerDelegate>delegate;

@end

@protocol CCContentViewControllerDelegate <NSObject>

- (void)viewController:(CCContentViewController *)viewController pageIndex:(NSInteger)pageIndex;

@end