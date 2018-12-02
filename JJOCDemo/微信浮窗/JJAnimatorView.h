//
//  JJAnimatorView.h
//  JJDemo
//
//  Created by Mr.JJ on 2018/11/28.
//  Copyright © 2018 yejiajun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJAnimatorView : UIImageView

- (void)startAnimateWithView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end

NS_ASSUME_NONNULL_END
