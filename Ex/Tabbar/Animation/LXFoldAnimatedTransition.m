//
//  LXFoldAnimatedTransition.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/28.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "LXFoldAnimatedTransition.h"

@implementation LXFoldAnimatedTransition
- (instancetype)init {
    if (self = [super init]) {
        self.folds = 2;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    UIView * containerView = [transitionContext containerView];

    toView.frame = [transitionContext finalFrameForViewController:toVC];
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    [containerView addSubview:toView];

    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.005;
    containerView.layer.sublayerTransform = transform;

    CGSize size = toView.frame.size;

    float foldWidth = size.width * 0.5 / (float)self.folds;

    NSMutableArray *fromViewFolds = [NSMutableArray array];
    NSMutableArray *toViewFolds = [NSMutableArray array];

    for (int i = 0; i < self.folds; i++) {
        float offset = (float)i * foldWidth * 2;

        UIView *leftFromViewFold = [self createSnapshotFromView:fromView afterUpdates:NO location:offset left:YES];
        leftFromViewFold.layer.position = CGPointMake(offset, size.height / 2);
        [fromViewFolds addObject:leftFromViewFold];
        [leftFromViewFold.subviews[1] setAlpha:0];

        UIView *rightFromViewFold = [self createSnapshotFromView:fromView afterUpdates:NO location:offset + foldWidth left:NO];
        rightFromViewFold.layer.position = CGPointMake(offset + foldWidth * 2, size.height / 2);
        [fromViewFolds addObject:rightFromViewFold];
        [rightFromViewFold.subviews[1] setAlpha:0];

        UIView *leftToViewFold = [self createSnapshotFromView:toView afterUpdates:YES location:offset left:YES];
        leftToViewFold.layer.position = CGPointMake(self.reverse ? size.width : 0, size.height / 2);
        leftToViewFold.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
        [toViewFolds addObject:leftToViewFold];

        UIView *rightToViewFold = [self createSnapshotFromView:toView afterUpdates:YES location:offset + foldWidth left:NO];
        rightToViewFold.layer.position = CGPointMake(self.reverse ? size.width : 0, size.height / 2);
        rightToViewFold.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        [toViewFolds addObject:rightToViewFold];
    }

    fromView.frame = CGRectOffset(fromView.frame, fromView.frame.size.width, 0);

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        for (int i = 0; i < self.folds; i++) {
            float offset = (float)i * foldWidth * 2;

            UIView *leftFromView = fromViewFolds[i * 2];
            leftFromView.layer.position = CGPointMake(self.reverse ? 0 : size.width, size.height / 2);
            leftFromView.layer.transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
            [leftFromView.subviews[1] setAlpha:1];

            UIView *rightFromView = fromViewFolds[i * 2 + 1];
            rightFromView.layer.position = CGPointMake(self.reverse ? 0 : size.width, size.height / 2);
            rightFromView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
            [rightFromView.subviews[1] setAlpha:1];

            UIView *leftToView = toViewFolds[i * 2];
            leftToView.layer.position = CGPointMake(offset, size.height / 2);
            leftToView.layer.transform = CATransform3DIdentity;
            [leftToView.subviews[1] setAlpha:0];

            UIView *rightToView = toViewFolds[i * 2 + 1];
            rightToView.layer.position = CGPointMake(offset + foldWidth * 2, size.height / 2);
            rightToView.layer.transform = CATransform3DIdentity;
            [rightToView.subviews[1] setAlpha:0];
        }
    } completion:^(BOOL finished) {
        for (UIView *view in toViewFolds) {
            [view removeFromSuperview];
        }
        for (UIView *view in fromViewFolds) {
            [view removeFromSuperview];
        }

        BOOL transitionFinished = ![transitionContext transitionWasCancelled];
        if (transitionFinished) {
            toView.frame = containerView.bounds;
            fromView.frame = containerView.bounds;
        } else {
            fromView.frame = containerView.bounds;
        }

        [transitionContext completeTransition:transitionFinished];
    }];
}

- (UIView *)createSnapshotFromView:(UIView *)view afterUpdates:(BOOL)afterUpdates location:(CGFloat)offset left:(BOOL)left {
    CGSize size = view.frame.size;
    UIView *containerView = view.superview;
    float foldWidth = size.width * 0.5 / (float)self.folds;

    UIView *snapshotView;

    if (!afterUpdates) {
        CGRect snapshotRegion = CGRectMake(offset, 0, foldWidth, size.height);
        snapshotView = [view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    } else {
        snapshotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, foldWidth, size.height)];
        snapshotView.backgroundColor = view.backgroundColor;
        CGRect snapshotRegion = CGRectMake(offset, 0, foldWidth, size.height);
        UIView *snapshotView2 = [view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
        [snapshotView addSubview:snapshotView2];
    }

    UIView *snapshotWithShadowView = [self addShadowToView:snapshotView reverse:left];

    [containerView addSubview:snapshotWithShadowView];

    snapshotWithShadowView.layer.anchorPoint = CGPointMake(left ? 0 : 1.0, 0.5);

    return snapshotWithShadowView;
}

- (UIView *)addShadowToView:(UIView *)view reverse:(BOOL)reverse {
    UIView *viewWithShadow = [[UIView alloc]initWithFrame:view.frame];

    UIView *shadowView = [[UIView alloc]initWithFrame:viewWithShadow.bounds];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = shadowView.bounds;
    gradientLayer.colors = @[
                             (id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                             (id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor
                             ];
    gradientLayer.startPoint = CGPointMake(reverse ? 0 : 1.0, reverse ? 0.2 : 0);
    gradientLayer.endPoint = CGPointMake(reverse ? 1.0 : 0, reverse ? 0 : 1.0);
    [shadowView.layer insertSublayer:gradientLayer atIndex:1];

    view.frame = view.bounds;
    [viewWithShadow addSubview:view];

    [viewWithShadow addSubview:shadowView];

    return viewWithShadow;
}
@end
