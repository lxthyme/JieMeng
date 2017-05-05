//
//  ViewController.m
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/4/27.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

#import "ViewController.h"

#import "PanelView.h"

@interface ViewController ()
{

}
@property (nonatomic,retain)UIView *animView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.animView];
    [self testPanelView];
}
- (void)testPanelView {
    PanelView *panelView = [[PanelView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:panelView];
}
- (IBAction)btnAnimationClick:(id)sender {
    [self lxBasicAnimation_byValue];
}

- (void)lxBasicAnimation_byValue {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anim.duration = 1.f;
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(0,0,10,10)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(10,10,200,200)];
    anim.byValue  = [NSValue valueWithCGRect:self.animView.bounds];
    //    anim.toValue = (id)[UIColor redColor].CGColor;
    //    anim.fromValue =  (id)[UIColor blackColor].CGColor;

    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anim.repeatCount = 1;
//    anim.autoreverses = YES;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;

    [self.animView.layer addAnimation:anim forKey:nil];
}

#pragma mark - animView
- (UIView *)animView {
    if(!_animView){
        _animView = [[UIView alloc]init];
        _animView.bounds = CGRectMake(0, 0, 100, 100);
        _animView.center = self.view.center;
        _animView.backgroundColor = [UIColor magentaColor];
    }
    return _animView;
}

@end
