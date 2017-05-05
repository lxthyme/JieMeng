//
//  PanelBehavior.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "PanelBehavior.h"

@interface PanelBehavior()
{

}
@property (nonatomic,retain)id<UIDynamicItem> item;
@property (nonatomic,retain)UIDynamicItemBehavior *itemBehavior;
@property (nonatomic,retain)UIAttachmentBehavior *attachmentBehavior;
@end
@implementation PanelBehavior

- (instancetype)initWithItem:(id<UIDynamicItem>)item {
    if (self = [super init]) {
        _item = item;
        [self setup];
    }
    return self;
}
- (void)setup {
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:self.item attachedToAnchor:CGPointZero];
    attachmentBehavior.frequency = 3.5;
    attachmentBehavior.damping = .4;
    attachmentBehavior.length = 0;
    [self addChildBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;

    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[_item]];
    itemBehavior.density = 100;
    itemBehavior.resistance = 10;
    [self addChildBehavior:itemBehavior];
    self.itemBehavior = itemBehavior;
}

- (void)setTargetPoint:(CGPoint)targetPoint {
    _targetPoint = targetPoint;
    self.attachmentBehavior.anchorPoint = targetPoint;
}
- (void)setVelocity:(CGPoint)velocity {
    _velocity = velocity;
    CGPoint currentVelocity = [self.itemBehavior linearVelocityForItem:self.item];
    CGPoint velocityDelta = CGPointMake(velocity.x - currentVelocity.x, velocity.y - currentVelocity.y);
    [self.itemBehavior addLinearVelocity:velocityDelta forItem:self.item];
}
@end
