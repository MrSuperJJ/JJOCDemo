//
//  JJDistrictPickerView.h
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/12/4.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JJDistrictPickerViewDelegate <NSObject>

- (void)didClickConfirmButton;

@end

@interface JJDistrictPickerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, weak) id<JJDistrictPickerViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
