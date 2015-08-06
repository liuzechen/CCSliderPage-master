//
//  CCPageViewController.m
//  CCSliderPage
//
//  Created by v－ling on 15/7/17.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "CCPageViewController.h"
#import "CCContentViewController.h"
#import "CCSliderPageView.h"

#import "EXamContentViewController.h"

#define CCTopSliderHeight 40
#define NAVIGATIONBARHEIGHT 64
#define COLLECTION_EDGE UIEdgeInsetsMake(5, 5, 5, 5)

static NSString *const CELL_IDENTIFIER = @"CCIdentifier";

@interface CCPageViewController () <CCContentViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CCSliderPageView *sliderPageView;

@end

@implementation CCPageViewController

#pragma mark - getter && setter

- (NSArray *)contentViewControllers {
    if (!_contentViewControllers) {

        EXamContentViewController *examA = [[EXamContentViewController alloc] init];
        examA.pageIndex = 0;
        examA.view.backgroundColor = [UIColor grayColor];
        examA.delegate = self;

        CCContentViewController *examB = [[CCContentViewController alloc] init];
        examB.pageIndex = 1;
        examB.view.backgroundColor = [UIColor brownColor];
        examB.delegate = self;

        _contentViewControllers = @[examA, examB];
    }
    return _contentViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configSliderPageView];
    [self configPageViewController];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - Bug

- (void)configSliderPageView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];// 设置其布局方向
    flowLayout.sectionInset = COLLECTION_EDGE;                                // 设置其边界
    flowLayout.itemSize = CGSizeMake(100, 30);
    _sliderPageView = [[CCSliderPageView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBARHEIGHT, self.view.frame.size.width, CCTopSliderHeight) collectionViewLayout:flowLayout];

    _sliderPageView.dataSource = self;
    _sliderPageView.delegate = self;

    _sliderPageView.backgroundColor = [UIColor orangeColor];
    _sliderPageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_sliderPageView registerClass:[ExamCollectionCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [self.view addSubview:_sliderPageView];
}

- (void)configPageViewController {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:NULL];
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.sliderPageView.frame), [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - CGRectGetMaxY(self.sliderPageView.frame));
    self.pageViewController.dataSource = self;
    self.pageViewController.doubleSided = YES;
    [self.pageViewController didMoveToParentViewController:self];
    [self.pageViewController setViewControllers:@[[self.contentViewControllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark - UIPageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((CCContentViewController *)viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index -= 1;
    return [self.contentViewControllers objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((CCContentViewController *)viewController).pageIndex;
    index += 1;
    if (index == self.contentViewControllers.count) {
        return nil;
    }
    return [self.contentViewControllers objectAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

#pragma mark - CCContentViewController Delegate
- (void)viewController:(CCContentViewController *)viewController pageIndex:(NSInteger)pageIndex {
    [self.view endEditing:NO];
    self.currentPageIndex = pageIndex;
}

#pragma mark - UICollection DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExamCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"Create Cell Error...");
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UICollection Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIPageViewControllerNavigationDirection direction = indexPath.row > self.currentPageIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [_pageViewController setViewControllers:@[[self.contentViewControllers objectAtIndex:indexPath.row]] direction:direction animated:YES completion:nil];
}

@end
