//
//  JJAnimator.h
//  JJDemo
//
//  Created by Mr.JJ on 2018/11/28.
//  Copyright © 2018 yejiajun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect currentFrame;

@end

NS_ASSUME_NONNULL_END
