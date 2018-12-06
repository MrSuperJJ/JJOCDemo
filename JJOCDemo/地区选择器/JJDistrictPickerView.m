//
//  JJDistrictPickerView.m
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/12/4.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJDistrictPickerView.h"
#import <Masonry/Masonry.h>

@interface JJDistrictPickerView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation JJDistrictPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.maskView];
        [self addSubview:self.topView];
        [self.topView addSubview:self.titleLabel];
        [self.topView addSubview:self.cancelButton];
        [self.topView addSubview:self.confirmButton];
        [self addSubview:self.pickerView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.pickerView.mas_top);
        make.height.mas_equalTo(Fit(61));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.topView).mas_offset(Fit(18));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-Fit(18));
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(Fit(185));
    }];
}

#pragma mark - private methods
- (void)maskViewClicked:(UIGestureRecognizer *)sender {
    self.hidden = YES;
}

- (void)cancelButtonClicked:(UIButton *)sender {
    self.hidden = YES;
}

- (void)confirmButtonClicked:(UIButton *)sender {
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(didClickConfirmButton)]) {
        [self.delegate didClickConfirmButton];
    }
}

#pragma mark - getters and setters
- (UIView *)maskView {
    if (nil == _maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClicked:)];
        [_maskView addGestureRecognizer:tapGestureRecognizer];
    }
    return _maskView;
}

- (UIView *)topView {
    if (nil == _topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"所在地区";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:Fit(18)];
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (nil == _cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:Fit(16)];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:Fit(16)];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIPickerView *)pickerView {
    if (nil == _pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}


@end
