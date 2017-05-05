//
//  LXBasePercentDrivenInteractiveTransition.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/2.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "LXBasePercentDrivenInteractiveTransition.h"

@implementation LXBasePercentDrivenInteractiveTransition
- (void)wireToVC:(UIViewController *)vc forOperation:(LXInteractionOperation)operation {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}
@end
