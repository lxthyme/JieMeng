//
//  PhotoCell.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/4.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "PhotoCell.h"

#import "LXCAAnimation-Swift.h"

@implementation PhotoCell
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    [self addSubview:self.imgView];
}
#pragma mark - imgView
- (UIImageView *)imgView {
    if(!_imgView){
        _imgView = [Component _imgView];
    }
    return _imgView;
}
@end
