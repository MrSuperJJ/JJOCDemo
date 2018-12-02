//
//  JJQQCustomNavBar.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2018/12/2.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJQQCustomNavBar.h"

@interface JJQQCustomNavBar ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JJQQCustomNavBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.titleLabel];
}

#pragma mark - getters and setters
- (UIButton *)leftButton {
    if (nil == _leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(15, 32, 40, 20);
        [_leftButton setTitle:self.leftText forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (nil == _rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 30, 32, 40, 20);
        [_rightButton setTitle:self.rightText forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 40) / 2, 32, 40, 20)];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}



@end
