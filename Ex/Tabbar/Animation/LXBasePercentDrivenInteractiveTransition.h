//
//  LXBasePercentDrivenInteractiveTransition.h
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/2.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LXInteractionOperation) {
    /**
     Indicates that the interaction controller should start a navigation controller 'pop' navigation.
     */
    LXInteractionOperationPop,
    /**
     Indicates that the interaction controller should initiate a modal 'dismiss'.
     */
    LXInteractionOperationDismiss,
    /**
     Indicates that the interaction controller should navigate between tabs.
     */
    LXInteractionOperationTab
};
@interface LXBasePercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
{

}
@property (nonatomic,assign)BOOL interactionInProgress;

- (void)wireToVC:(UIViewController *)vc forOperation:(LXInteractionOperation)operation;

@end
