//
//  LXTabbarVC.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/28.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "LXTabbarVC.h"

//#import "CEFoldAnimationController.h"
//#import "CEHorizontalSwipeInteractionController.h"

#import "LXFoldAnimatedTransition.h"
#import "LXHorizontalSwipeInteractionTransition.h"

@interface LXTabbarVC ()<UITabBarControllerDelegate>
{
//    CEFoldAnimationController *_foldAnimation;
//    CEHorizontalSwipeInteractionController *_swipeIA;

    LXHorizontalSwipeInteractionTransition *_swipeIA;
    LXFoldAnimatedTransition *_foldAnimation;
}
@end

@implementation LXTabbarVC
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        self.delegate = self;

//        _foldAnimation = [[CEFoldAnimationController alloc]init];
//        _swipeIA = [[CEHorizontalSwipeInteractionController alloc]init];

        _foldAnimation = [[LXFoldAnimatedTransition alloc]init];
        _swipeIA = [[LXHorizontalSwipeInteractionTransition alloc]init];

        _foldAnimation.folds = 3;

        [self addObserver:self forKeyPath:@"selectedViewController" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(NSStringFromClass(self.class))];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectedViewController"]) {
//        [_swipeIA wireToViewController:self.selectedViewController forOperation:CEInteractionOperationTab];
        [_swipeIA wireToVC:self.selectedViewController forOperation:LXInteractionOperationTab];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UITabBarControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC{
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    _foldAnimation.reverse = fromVCIndex < toVCIndex;
    return _foldAnimation;
}
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController {
    NSLog(@"_swipeIA.interactionInProgress: %@", _swipeIA.interactionInProgress ? @"YES" : @"NO");
    return _swipeIA.interactionInProgress ? _swipeIA : nil;
}
@end
