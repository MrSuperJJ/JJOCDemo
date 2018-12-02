//
//  JJQQCustomNavBar.h
//  JJOCDemo
//
//  Created by Mr.JJ on 2018/12/2.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJQQCustomNavBar : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *leftTextColor;
@property (nonatomic, strong) UIColor *rightTextColor;;

@end

NS_ASSUME_NONNULL_END
