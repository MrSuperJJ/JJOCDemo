//
//  JJAnimatorView.m
//  JJDemo
//
//  Created by Mr.JJ on 2018/11/28.
//  Copyright © 2018 yejiajun. All rights reserved.
//

#import "JJAnimatorView.h"

@interface JJAnimatorView () <CAAnimationDelegate>

@end

@implementation JJAnimatorView
{
    CAShapeLayer *shapeLayer;
    UIView *toView;
}

- (void)startAnimateWithView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect {

    toView = theView;

    ///mask 和floatingButton大小一致的mask
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30.f].CGPath;
    self.layer.mask = shapeLayer;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30.f].CGPath;
    animation.duration = 0.5f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [shapeLayer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    toView.hidden = NO;
    [shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}


@end
