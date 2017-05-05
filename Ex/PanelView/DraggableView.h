//
//  DraggableView.h
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DraggableView;

@protocol DraggableViewDelegate

- (void)draggableView:(DraggableView *)draggableView draggingEndedWithVelocity:(CGPoint)velocity;

- (void)draggableViewBeginDragging:(DraggableView *)draggableView;

@end
@interface DraggableView : UIView
{

}
@property (nonatomic,assign)id<DraggableViewDelegate> delegate;

@end
