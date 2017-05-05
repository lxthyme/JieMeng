//
//  PanelView.h
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PanelState) {
    PanelOpenState,
    PanelClosedState
};

@interface PanelView : UIView
{

}
@property (nonatomic,assign)PanelState panelState;
@end
