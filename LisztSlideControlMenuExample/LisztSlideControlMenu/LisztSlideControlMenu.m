//
//  LisztSlideControlMenu.m
//  LisztSlideControlMenuExample
//
//  Created by Liszt on 2017/5/10.
//  Copyright © 2017年 LisztCoder. All rights reserved.
//

#import "LisztSlideControlMenu.h"

@interface LisztSlideControlMenu()
{
    /*记录起始位置*/
    CGPoint _originalPoint;
    
}

@end

@implementation LisztSlideControlMenu

+ (instancetype)defaultSlideMenu{
    LisztSlideControlMenu *defaultSlideMenu = [[self alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    return defaultSlideMenu;
}

- (void)showModal:(LisztSlideControlModal)modal controlMenu:(UIView *)controlMenu{
    _slideControlModal = modal;
    _controlMenu = controlMenu;
    [self configSelf];
    
    switch (_slideControlModal) {
        case LisztSlideControlLeft:
        {
            __block CGRect tempRect = CGRectMake(-CGRectGetWidth(self.frame) - margin, 0, CGRectGetWidth(self.frame) - margin, CGRectGetHeight(self.frame));
            _controlMenu.frame = tempRect;
            [UIView animateWithDuration:0.3 animations:^{
                self.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.3f];
                tempRect.origin.x = 0;
                _controlMenu.frame = tempRect;
            }];
        }
            break;
        case LisztSlideControlRight:
        {
            __block CGRect tempRect = CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame) - margin, CGRectGetHeight(self.frame));
            _controlMenu.frame = tempRect;
            [UIView animateWithDuration:0.3 animations:^{
                self.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.3f];
                tempRect.origin.x = margin;
                _controlMenu.frame = tempRect;
            }];
        }
            break;
        default:
            break;
    }
}

- (void)configSelf{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 1;
    _controlMenu.backgroundColor = [UIColor cyanColor];
    
    _controlMenu.layer.shadowColor =[UIColor cyanColor].CGColor;
    _controlMenu.layer.shadowOffset = CGSizeMake(0.5, 0);
    _controlMenu.layer.shadowOpacity = 1.0;
    _controlMenu.layer.shadowOffset = CGSizeMake(0.5, 0);
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)]];
    [self addSubview:_controlMenu];
    
    UIPanGestureRecognizer *viewPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self addGestureRecognizer:viewPanGesture];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panRecognizer{
    switch (panRecognizer.state) {
            /*记录起始位置 方便拖拽移动*/
        case UIGestureRecognizerStateBegan:
            _originalPoint = _controlMenu.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self panChangedStateRecognizer:panRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
            if(CGRectGetMaxX(_controlMenu.frame)<=CGRectGetWidth(_controlMenu.frame)*0.8){
                [UIView animateWithDuration:0.15 animations:^{
                    self.alpha = 0;
                    _controlMenu.frame = CGRectMake(-CGRectGetWidth(_controlMenu.frame), 0, CGRectGetWidth(_controlMenu.frame), CGRectGetHeight(_controlMenu.frame));
                }];
            }
            if(CGRectGetMaxX(_controlMenu.frame)>=CGRectGetWidth(_controlMenu.frame)*0.2){
                [UIView animateWithDuration:0.15 animations:^{
                    _controlMenu.frame = CGRectMake(0, 0, CGRectGetWidth(_controlMenu.frame), CGRectGetHeight(_controlMenu.frame));
                }];
            }
            
            break;
        default:
            break;
    }
}

- (void)panChangedStateRecognizer:(UIPanGestureRecognizer *)pan{
    /*拖拽的距离*/
    CGPoint translation = [pan translationInView:self];
    switch (_slideControlModal) {
        case LisztSlideControlLeft:
        {
            _controlMenu.center = CGPointMake(_originalPoint.x + translation.x, _controlMenu.center.y);
            
            if(CGRectGetMaxX(_controlMenu.frame)<=0){
                _controlMenu.frame = CGRectMake(-CGRectGetWidth(_controlMenu.frame), 0, CGRectGetWidth(_controlMenu.frame), CGRectGetHeight(_controlMenu.frame));
            }
            if(CGRectGetMaxX(_controlMenu.frame)>=CGRectGetWidth(_controlMenu.frame)){
                _controlMenu.frame = CGRectMake(0, 0, CGRectGetWidth(_controlMenu.frame), CGRectGetHeight(_controlMenu.frame));
            }
        }
            break;
        case LisztSlideControlRight:
        {
            /*右侧待定*/
            
        }
            break;
            
        default:
            break;
    }
}

- (void)tapAction{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        _controlMenu.frame = CGRectMake(-CGRectGetWidth(_controlMenu.frame), 0, CGRectGetWidth(_controlMenu.frame), CGRectGetHeight(_controlMenu.frame));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
