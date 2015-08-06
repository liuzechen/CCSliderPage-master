//
//  CCSliderPageView.m
//  CCSliderPage
//
//  Created by v－ling on 15/7/18.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "CCSliderPageView.h"

@interface ExamCollectionCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ExamCollectionCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end

@implementation CCSliderPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
