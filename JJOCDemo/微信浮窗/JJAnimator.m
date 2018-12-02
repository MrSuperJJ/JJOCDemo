//
//  JJAnimator.m
//  JJDemo
//
//  Created by Mr.JJ on 2018/11/28.
//  Copyright © 2018 yejiajun. All rights reserved.
//

#import "JJAnimator.h"
#import "JJAnimatorView.h"

@implementation JJAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    return 1.f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    ///transitionContext：fromView, fromViewController, toView, toViewController, containerView
    ///A控制器 跳转到 B控制器

    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    [containerView addSubview:toView];

    JJAnimatorView *animatorView = [[JJAnimatorView alloc] initWithFrame:toView.bounds];
    [containerView addSubview:animatorView];

    ///截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    toView.hidden = YES;

    ///animatorView，它是从floatingButton当前的frame，展开到toView
    [animatorView startAnimateWithView:toView fromRect:self.currentFrame toRect:toView.frame];

    ///移除fromViewContrller
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:YES];
    });
}

@end
