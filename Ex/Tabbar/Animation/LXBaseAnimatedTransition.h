//
//  LXBaseAnimatedTransition.h
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/28.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LXBaseAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>
{

}
@property (nonatomic,assign)BOOL reverse;
@property (nonatomic,assign)NSTimeInterval duration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;
@end
