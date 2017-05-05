//
//  LXHorizontalSwipeInteractionTransition.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/2.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "LXHorizontalSwipeInteractionTransition.h"

#import <objc/runtime.h>

const NSString *kLXHorizontalSwipeGestureKey = @"kLXHorizontalSwipeGestureKey";
@interface LXHorizontalSwipeInteractionTransition()
{
    BOOL _shouldCompleteTransition;
    UIViewController *_vc;
    LXInteractionOperation _operation;
}
@end
@implementation LXHorizontalSwipeInteractionTransition
- (void)wireToVC:(UIViewController *)vc forOperation:(LXInteractionOperation)operation {
    self.popOnRightToLeft = YES;
    _operation = operation;
    _vc = vc;
    [self prepareGestureRecognizerInView:vc.view];
}
- (void)prepareGestureRecognizerInView:(UIView *)view {
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(view, (__bridge const void *)(kLXHorizontalSwipeGestureKey));

    if (pan) {
        [view removeGestureRecognizer:pan];
    }

    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [view addGestureRecognizer:pan];

    objc_setAssociatedObject(view, (__bridge const void *)(kLXHorizontalSwipeGestureKey), pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)panGesture:(UIPanGestureRecognizer *)panRecognizer {
    CGPoint translation = [panRecognizer translationInView:panRecognizer.view];
    CGPoint velocity = [panRecognizer velocityInView:panRecognizer.view];

    switch (panRecognizer.state) {
        case UIGestureRecognizerStatePossible: {
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        }
        case UIGestureRecognizerStateBegan: {
            [self gestureRecognizerStateBeganWithVelocity:velocity];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self gestureRecognizerStateChangedWithTranslation:translation];
            break;
        }
        case UIGestureRecognizerStateEnded://UIGestureRecognizerStateRecognized
        case UIGestureRecognizerStateCancelled: {
            [self gestureRecognizerStateEndedOrCancelled:panRecognizer];
            break;
        }
        case UIGestureRecognizerStateFailed: {
            NSLog(@"UIGestureRecognizerStateFailed");
            break;
        }
        default:
            break;
    }
}
- (void)gestureRecognizerStateBeganWithVelocity:(CGPoint)velocity {
    BOOL rightToLeftSwipe = velocity.x < 0;

    if (_operation == LXInteractionOperationPop) {
        if ((self.popOnRightToLeft && rightToLeftSwipe) || (!self.popOnRightToLeft && !rightToLeftSwipe)) {
            self.interactionInProgress = YES;
            [_vc.navigationController popViewControllerAnimated:YES];
        }
    }else if(_operation == LXInteractionOperationTab){
        if (rightToLeftSwipe) {
            if (_vc.tabBarController.selectedIndex < _vc.tabBarController.viewControllers.count - 1) {
                self.interactionInProgress = YES;
                _vc.tabBarController.selectedIndex++;
            }
        } else {
            if (_vc.tabBarController.selectedIndex > 0) {
                self.interactionInProgress = YES;
                _vc.tabBarController.selectedIndex--;
            }
        }
    } else {
        self.interactionInProgress = YES;
        [_vc dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)gestureRecognizerStateChangedWithTranslation:(CGPoint)translation {
    if (self.interactionInProgress) {
        CGFloat fraction = fabs(translation.x / 200.0);
        fraction = fminf(fmaxf(fraction, 0.0), 1.0);
        _shouldCompleteTransition = fraction > 0.5;

        if (fraction >= 1.0) {
            fraction = 0.99;

            [self updateInteractiveTransition:fraction];
        }

    }
}

- (void)gestureRecognizerStateEndedOrCancelled:(UIPanGestureRecognizer *)panRecognizer {
    if (self.interactionInProgress) {
        self.interactionInProgress = NO;
        if (!_shouldCompleteTransition || panRecognizer.state == UIGestureRecognizerStateCancelled) {
            [self cancelInteractiveTransition];
        }
    } else {
        [self finishInteractiveTransition];
    }
}
@end
