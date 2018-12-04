//
//  JJDistrictPickerView.m
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/12/4.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJDistrictPickerView.h"

static const NSUInteger TitleLabelHeight = 20;
static const NSUInteger PickerViewHeight = 200;
static const NSUInteger ConfirmButtonHeight = 20;

@interface JJDistrictPickerView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation JJDistrictPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.pickerView];
        [self addSubview:self.confirmButton];
    }
    return self;
}


#pragma mark - getters and setters
- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TitleLabelHeight)];
        _titleLabel.text = @"省市区选择";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIPickerView *)pickerView {
    if (nil == _pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.titleLabel.frame.origin.y + TitleLabelHeight, self.frame.size.width, PickerViewHeight)];
    }
    return _pickerView;
}

- (UIButton *)confirmButton {
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.pickerView.frame.origin.y + PickerViewHeight, self.frame.size.width, ConfirmButtonHeight)];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_confirmButton];
    }
    return _confirmButton;
}

@end
