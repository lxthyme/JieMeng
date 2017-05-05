//
//  LXBaseAnimatedTransition.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/28.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "LXBaseAnimatedTransition.h"

@implementation LXBaseAnimatedTransition
- (instancetype)init {
    if (self = [super init]) {
        self.duration = 1.0f;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
}
@end
