//
//  DraggableView.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "DraggableView.h"

@implementation DraggableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer *)panRecognizer {
    CGPoint point = [panRecognizer translationInView:self.superview];
    self.center = CGPointMake(self.center.x, self.center.y + point.y);
    [panRecognizer setTranslation:CGPointZero inView:self.superview];
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panRecognizer velocityInView:self.superview];
        velocity.x = 0;
        [self.delegate draggableView:self draggingEndedWithVelocity:velocity];
    }else if(panRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.delegate draggableViewBeginDragging:self];
    }
}
@end
