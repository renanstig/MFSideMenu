//
//  MFSideMenuShadow.m
//  MFSideMenuDemoSearchBar
//
//  Created by Michael Frederick on 5/13/13.
//  Copyright (c) 2013 Frederick Development. All rights reserved.
//

#import "MFSideMenuShadow.h"
#import <QuartzCore/QuartzCore.h>

@implementation MFSideMenuShadow

@synthesize color = _color;
@synthesize opacity = _opacity;
@synthesize radius = _radius;
@synthesize enabled = _enabled;
@synthesize shadowedView;

+ (MFSideMenuShadow *)shadowWithView:(UIView *)shadowedView {
    MFSideMenuShadow *shadow = [MFSideMenuShadow shadowWithColor:[UIColor blackColor] radius:10.0f opacity:0.75f];
    shadow.shadowedView = shadowedView;
    return shadow;
}

+ (MFSideMenuShadow *)shadowWithColor:(UIColor *)color radius:(CGFloat)radius opacity:(CGFloat)opacity {
    MFSideMenuShadow *shadow = [MFSideMenuShadow new];
    shadow.color = color;
    shadow.radius = radius;
    shadow.opacity = opacity;
    return shadow;
}

- (id)init {
    self = [super init];
    if(self) {
        self.color = [UIColor blackColor];
        self.opacity = 0.75f;
        self.radius = 10.0f;
        self.enabled = YES;
    }
    return self;
}


#pragma mark -
#pragma mark - Property Setters

- (void)setEnabled:(BOOL)shadowEnabled {
    _enabled = shadowEnabled;
    [self draw];
}

- (void)setRadius:(CGFloat)shadowRadius {
    _radius = shadowRadius;
    [self draw];
}

- (void)setColor:(UIColor *)shadowColor {
    _color = shadowColor;
    [self draw];
}

- (void)setOpacity:(CGFloat)shadowOpacity {
    _opacity = shadowOpacity;
    [self draw];
}


#pragma mark -
#pragma mark - Drawing

- (void)draw {
    if(_enabled) {
        [self show];
    } else {
        [self hide];
    }
}

- (void)show {
    CGRect pathRect = self.shadowedView.bounds;
    pathRect.size = self.shadowedView.frame.size;
    self.shadowedView.layer.shadowPath = [UIBezierPath bezierPathWithRect:pathRect].CGPath;
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.borderColor = [[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:135/255.0 alpha:1.0] CGColor];
    rightBorder.borderWidth = 0.5;
    rightBorder.frame = CGRectMake(0, 60, 0.5, pathRect.size.height);
    
    [self.shadowedView.layer addSublayer:rightBorder];
    
    
    //    self.shadowedView.layer.borderWidth = 0.5;
    //    self.shadowedView.layer.borderColor =
    
    //self.shadowedView.layer.shadowOpacity = self.opacity;
    //self.shadowedView.layer.shadowRadius = self.radius;
    //self.shadowedView.layer.shadowColor = [self.color CGColor];
    //self.shadowedView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)hide {
    self.shadowedView.layer.shadowOpacity = 0.0f;
    self.shadowedView.layer.shadowRadius = 0.0f;
}


#pragma mark -
#pragma mark - ShadowedView Rotation

- (void)shadowedViewWillRotate {
    self.shadowedView.layer.shadowPath = nil;
    self.shadowedView.layer.shouldRasterize = YES;
}

- (void)shadowedViewDidRotate {
    [self draw];
    self.shadowedView.layer.shouldRasterize = NO;
}

@end
