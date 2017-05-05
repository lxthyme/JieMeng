//
//  PanelView.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "PanelView.h"

#import "DraggableView.h"
#import "PanelBehavior.h"

@interface PanelView()<DraggableViewDelegate>
{

}
@property (nonatomic,retain)DraggableView *draggableView;
@property (nonatomic,retain)UIDynamicAnimator *animator;
@property (nonatomic,retain)PanelBehavior *panelBehavior;
@end
@implementation PanelView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];

    CGSize size = self.bounds.size;
    self.panelState = PanelClosedState;
    self.draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(0, size.height * .75, size.width, size.height)];
    self.draggableView.backgroundColor = [UIColor magentaColor];
    self.draggableView.layer.cornerRadius = 10;
    self.draggableView.delegate = self;
    [self addSubview:self.draggableView];

    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}
- (void)tap:(UIPanGestureRecognizer *)panRecognizer {
    self.panelState = self.panelState == PanelOpenState ? PanelClosedState : PanelOpenState;
    [self animatePanelWithInitialVelocity:self.panelBehavior.velocity];
}
- (void)animatePanelWithInitialVelocity:(CGPoint)initialVelocity {
    if (!self.panelBehavior) {
        self.panelBehavior = [[PanelBehavior alloc]initWithItem:self.draggableView];
    }
    self.panelBehavior.targetPoint = [self targetPoint];
    self.panelBehavior.velocity = initialVelocity;
    [self.animator addBehavior:self.panelBehavior];
}
- (CGPoint)targetPoint {
    CGSize size = self.bounds.size;
    return self.panelState == PanelClosedState > 0 ?CGPointMake(size.width / 2, size.height * 1.25) : CGPointMake(size.width / 2, size.height / 2 + 50);
}
#pragma mark - DraggableViewDelegate
- (void)draggableView:(DraggableView *)draggableView draggingEndedWithVelocity:(CGPoint)velocity {
    PanelState panelState = velocity.y > 0 ? PanelClosedState : PanelOpenState;
    self.panelState = panelState;

    [self animatePanelWithInitialVelocity:velocity];
}

- (void)draggableViewBeginDragging:(DraggableView *)draggableView {
    [self.animator removeAllBehaviors];
}
@end
