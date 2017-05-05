//
//  PanelBehavior.h
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelBehavior : UIDynamicBehavior {

}


/** <#注释#>*/
@property (nonatomic,assign)CGPoint targetPoint;
@property (nonatomic,assign)CGPoint velocity;

- (instancetype)initWithItem:(id<UIDynamicItem>)item;

@end
