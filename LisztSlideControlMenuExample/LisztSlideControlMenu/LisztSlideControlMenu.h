//
//  LisztSlideControlMenu.h
//  LisztSlideControlMenuExample
//
//  Created by Liszt on 2017/5/10.
//  Copyright © 2017年 LisztCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat margin = 130;

typedef NS_ENUM(NSUInteger,LisztSlideControlModal) {
    /*左边显示*/
    LisztSlideControlLeft,
    /*右边显示*/
    LisztSlideControlRight
};

@interface LisztSlideControlMenu : UIView{
    LisztSlideControlModal _slideControlModal;
    UIView *_controlMenu;
}

/*
 @breaf 得到滑动菜单
 */
+ (instancetype)defaultSlideMenu;

/*
 @breaf
 
 @param modal 显示方式
 @param controlMenu 显示的菜单
 */
- (void)showModal:(LisztSlideControlModal)modal controlMenu:(UIView *)controlMenu;

@end
