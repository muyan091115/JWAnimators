//
//  JWAnimators.m
//  JiangWei_Sport_Demo_01
//
//  Created by 蒋伟 on 2017/3/11.
//  Copyright © 2017年 jiangwei. All rights reserved.
//

#import "JWAnimators.h"

typedef NS_ENUM(NSInteger, JWAnimatorsType) {
    JWAnimatorsPresent = 0,
    JWAnimatorsDismiss = 1
};

@interface JWAnimators() <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@end

@implementation JWAnimators {
    
    JWAnimatorsType _animatorsType;
    __weak id <UIViewControllerContextTransitioning> _transitionContext;
    
}

//告诉控制器谁来提供展现动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _animatorsType = JWAnimatorsPresent;
    return self;
}

//告诉控制器谁来提供消失动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _animatorsType = JWAnimatorsDismiss;
    return self;
}


//动画时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 5.0;
}

//实现动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    // 获取容器试图容器视图
    UIView *containerView = [transitionContext containerView];
    
    // 根据之前记录的_animatorsType属性，来确定执行动画的到底是 toView 还是 fromView
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *view;
    
    if (_animatorsType == JWAnimatorsPresent) {
        view = toView;
    } else {
        view = fromView;
    }
    
    if (_animatorsType == JWAnimatorsPresent) {
        [containerView addSubview:view];
    }
    
    // 这个就是在视图上进行自定义动画，在下节中讲解
    [self circleAnimWithView:view];
    
    //自定义全局变量，见下文
    _transitionContext = transitionContext;
    
}

- (void)circleAnimWithView:(UIView *)view {
    
    //1. 实例化一个 CAShapeLayer 对象
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    //2.设置容器试图的 mask 属性为这个 CAShapeLayer 对象
    view.layer.mask = layer;
    
    //3.为 CAShapeLayer 对象的 path 属性赋值一个贝塞尔路径
    CGFloat radius = 50;
    CGFloat viewWidth = view.bounds.size.width;
    CGFloat viewHeight = view.bounds.size.height;
    CGRect rect = CGRectMake(120, viewHeight - 120 - 50, radius, radius);
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    layer.path = beginPath.CGPath;
    
    //4.新建一个 CABasicAnimation 动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    
    //5.设置动画时长，开始和结束路径，填充模式
    CGFloat maxRadius = sqrt((viewWidth - 145) * (viewWidth - 145) + (viewHeight - 145) * (viewHeight - 145));
    
    CGRect endRect = CGRectInset(rect, -maxRadius, -maxRadius);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    anim.duration = [self transitionDuration:_transitionContext];
    if (_animatorsType == JWAnimatorsPresent) {
        anim.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(endPath.CGPath);
    } else {
        anim.fromValue = (__bridge id _Nullable)(endPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(beginPath.CGPath);
    }
    
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    
    //6.添加动画到 CAShapeLayer 层
    [layer addAnimation:anim forKey:nil];
    
}



#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_transitionContext completeTransition:YES];
}

@end

