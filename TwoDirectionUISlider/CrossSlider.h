//
//  CrossSlider.h
//  TwoDirectionUISlider
//
//  Created by Mahir Eusufzai on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CrossSlider : UIControl {
  
    UIImageView *thumb;
    UIImage *thumbNormal;
    UIImage *thumbPressed;
  
    float hValue;
    float vValue;
    
    float hMaximumValue;
    float hMinimumValue;
    float vMaximumValue;
    float vMinimumValue;
    
    CGPoint horizontalSliderCenter;
    CGPoint horizontalSliderSize;
    CGPoint verticalSliderCenter;
    CGPoint verticalSliderSize;
    
    CGRect horizontalSliderFrame;
    CGRect verticalSliderFrame;
   
    CGFloat hLeftBoundary;
    CGFloat hRightBoundary;
    CGFloat vTopBoundary;
    CGFloat vBottomBoundary;
    
    CGPoint distFromCenter;
    
    float hBoundarySpan;
    float vBoundarySpan;
    float hValueRange;
    float vValueRange;
}

@property (nonatomic, retain) UIImageView *thumb;
@property (nonatomic, assign) float hValue;
@property (nonatomic, assign) float vValue;
@property (nonatomic, assign) float hMinimumValue;
@property (nonatomic, assign) float hMaximumValue;
@property (nonatomic, assign) float vMaximumValue;
@property (nonatomic, assign) float vMinimumValue;

- (id)initWithFrame:(CGRect)frame hMinValue:(float)hMin hMaxValue:(float)hMax vMinValue:(float)vMin vMaxValue:(float)vMax currentHValue:(float)h currentVValue:(float)v;
- (void) setDefaultValues;
- (void) setUpThumb;
- (void) setUpPositions;
- (void) setUpHorizontalFrameAndBoundaries;
- (void) setUpVerticalFrameAndBoundaries;
- (void)addRoundedRect:(CGContextRef)context roundRect:(CGRect)rrect withRoundedCorner1:(BOOL)c1 corner2:(BOOL)c2 corner3:(BOOL)c3 corner4:(BOOL)c4 radius:(CGFloat)radius color:(UIColor *) color;
-(CGRect) makeRectFromCenter: (CGPoint) center size:(CGPoint)size;
-(void) updateValues;

@end
