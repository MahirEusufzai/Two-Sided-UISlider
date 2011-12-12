//
//  CrossSlider.m
//  TwoDirectionUISlider
//
//  Created by Mahir Eusufzai on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CrossSlider.h"
#define ksliderThickness  8

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 \
green:((c>>16)&0xFF)/255.0 \
blue:((c>>8)&0xFF)/255.0 \
alpha:((c)&0xFF)/255.0]


@implementation CrossSlider


@synthesize thumb,hValue, vValue, hMaximumValue, hMinimumValue, vMaximumValue, vMinimumValue;


#pragma mark Init


- (id)initWithFrame:(CGRect)frame hMinValue:(float)hMin hMaxValue:(float)hMax vMinValue:(float)vMin vMaxValue:(float)vMax currentHValue:(float)h currentVValue:(float)v {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        

        self.hMinimumValue = hMin;
        self.hMaximumValue = hMax;
        self.vMaximumValue = vMax;
        self.vMinimumValue = vMin;
        
        hValueRange = self.hMaximumValue - self.hMinimumValue;
        vValueRange = self.vMaximumValue - self.vMinimumValue;
        
        
        self.hValue = h;
        self.vValue = v;
        
        [self setUpThumb];

        [self setUpPositions];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
  
    self = [super initWithCoder:coder];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setUpThumb];
        [self setDefaultValues];
        [self setUpPositions];
        
       
    }
    return self;
}




- (id)init {
 
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 200, 100);
        self.backgroundColor = [UIColor clearColor];
        
        [self setUpThumb];
        [self setDefaultValues];
        [self setUpPositions];
        
    }
    return self;
}

- (void)dealloc
{
    [thumbNormal release];
    [thumbPressed release];
    
    [super dealloc];
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // must subtract self.frame.origin.x to account for change between frame and bounds
    
    horizontalSliderCenter = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y);
    
    horizontalSliderFrame = [self makeRectFromCenter:horizontalSliderCenter size:horizontalSliderSize];
    
    
    
    verticalSliderCenter = CGPointMake(self.thumb.center.x, self.center.y - self.frame.origin.y);
    
    verticalSliderFrame = [self makeRectFromCenter:verticalSliderCenter size:verticalSliderSize];
    
    
    
    CGRect hTracker = CGRectMake(horizontalSliderFrame.origin.x, horizontalSliderFrame.origin.y, self.thumb.center.x, ksliderThickness);
    
    CGRect vTracker = CGRectMake(CGRectGetMinX(verticalSliderFrame), CGRectGetMidY(verticalSliderFrame), ksliderThickness, self.thumb.center.y - CGRectGetMidY(verticalSliderFrame));
    
    
    [self addRoundedRect:context roundRect:horizontalSliderFrame withRoundedCorner1:YES corner2:YES corner3:YES corner4:YES radius:5 color:[UIColor lightGrayColor]];
    
    [self addRoundedRect:context roundRect:verticalSliderFrame withRoundedCorner1:YES corner2:YES corner3:YES corner4:YES radius:5 color:[UIColor lightGrayColor]];
    
    [self addRoundedRect:context roundRect:vTracker withRoundedCorner1:NO corner2:YES corner3:YES corner4:NO radius:5 color:HEXCOLOR(0x80d5ee)]; 
    
    [self addRoundedRect:context roundRect:hTracker withRoundedCorner1:YES corner2:NO corner3:NO corner4:YES radius:5 color:HEXCOLOR(0x80d5ee)]; 
}

#pragma mark  Tracking Methods

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    
    CGPoint firstTouch = [touch locationInView:self];
    
    if ( CGRectContainsPoint(self.thumb.frame, firstTouch))  {
        
        self.thumb.image = thumbPressed;
        
        distFromCenter = CGPointMake (firstTouch.x - self.thumb.center.x, firstTouch.y - self.thumb.center.y);
        
        return YES;
    }
    
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    
    CGPoint newTouch = [touch locationInView:self];
    
    
    CGRect thumbBoundaries = CGRectMake(hLeftBoundary + distFromCenter.x, vTopBoundary +distFromCenter.y,  hRightBoundary - hLeftBoundary + 1, vBottomBoundary - vTopBoundary + 1) ;
    
    if (CGRectContainsPoint(thumbBoundaries, newTouch)) {
        
        self.thumb.center = CGPointMake( newTouch.x - distFromCenter.x, newTouch.y - distFromCenter.y);
        
        [self setNeedsDisplay];
        [self updateValues];
        
    }
    return YES;
    
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    self.thumb.image = thumbNormal;
    
}



- (void) updateValues {
    
    float hLocation = self.thumb.center.x -  hLeftBoundary;
    self.hValue = hLocation/hBoundarySpan * hValueRange + self.hMinimumValue;
    
    
    float vLocation = vBoundarySpan - (self.thumb.center.y - vTopBoundary);
    self.vValue = vLocation/vBoundarySpan * vValueRange + self.vMinimumValue;
    
    NSLog(@"%f", self.thumb.center.x);
    
}

#pragma mark Set Up Methods

- (void) setDefaultValues {
    
    self.hMinimumValue = 0;
    self.hMaximumValue = 100;
    self.vMaximumValue = 50;
    self.vMinimumValue = 0;
    
    hValueRange = self.hMaximumValue - self.hMinimumValue;
    vValueRange = self.vMaximumValue - self.vMinimumValue;
    
    
    self.hValue = 50;
    self.vValue = 25;
    
}

- (void) setUpThumb {
    self.thumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];       
    
    thumbNormal = [UIImage imageNamed:@"thumb.png"];
    thumbPressed = [UIImage imageNamed:@"thumbPressed.png"];
    
    self.thumb.image = thumbNormal;
    
    [self addSubview:self.thumb];
    
}


- (void)setUpPositions {
    
    [self setUpHorizontalFrameAndBoundaries];
  
    CGFloat centerXValue = (self.hValue - self.hMinimumValue)/hValueRange * hBoundarySpan + hLeftBoundary;
    
    
    [self setUpVerticalFrameAndBoundaries];
    
    CGFloat centerYValue = vBottomBoundary - (self.vValue - vMinimumValue) / vValueRange * vBoundarySpan;

  
    self.thumb.center = CGPointMake(centerXValue, centerYValue);        
    

}



- (void) setUpHorizontalFrameAndBoundaries {
    
    horizontalSliderCenter = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y);
    
    horizontalSliderSize = CGPointMake(self.frame.size.width -ksliderThickness, ksliderThickness);
    
    horizontalSliderFrame = [self makeRectFromCenter:horizontalSliderCenter size:horizontalSliderSize];
    
    
    // these are the thumb's frame's horizontal boundaries in terms of its center
    
    hLeftBoundary = horizontalSliderFrame.origin.x + .5* ksliderThickness;
    
    hRightBoundary = horizontalSliderFrame.origin.x + horizontalSliderFrame.size.width - .5* ksliderThickness;
    
    hBoundarySpan =  hRightBoundary - hLeftBoundary;
    
    
}
- (void) setUpVerticalFrameAndBoundaries {
    
    verticalSliderCenter = CGPointMake(self.thumb.center.x, self.center.y - self.frame.origin.y);
    
    verticalSliderSize = CGPointMake(ksliderThickness, self.frame.size.height -ksliderThickness);
    
    verticalSliderFrame = [self makeRectFromCenter:verticalSliderCenter size:verticalSliderSize];
    
    
    // these are the thumb's vertical boundaries in terms of its center
    
    vTopBoundary = verticalSliderFrame.origin.y + .5* ksliderThickness;
    
    vBottomBoundary = verticalSliderFrame.origin.y +  verticalSliderFrame.size.height - .5* ksliderThickness;
    
    vBoundarySpan = vBottomBoundary - vTopBoundary;
    
    
}


#pragma mark Other

- (CGRect) makeRectFromCenter:(CGPoint)center size:(CGPoint)size {
    
    CGRect rect = CGRectMake(center.x - size.x / 2, center.y - size.y / 2 , size.x, size.y);
    
    return rect;
}

- (void)addRoundedRect:(CGContextRef)context roundRect:(CGRect)rrect withRoundedCorner1:(BOOL)c1 corner2:(BOOL)c2 corner3:(BOOL)c3 corner4:(BOOL)c4 radius:(CGFloat)radius color:(UIColor *)color
{	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, c1 ? radius : 0.0f);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, c2 ? radius : 0.0f);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, c3 ? radius : 0.0f);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, c4 ? radius : 0.0f);
    
    [color setFill];
    CGContextFillPath(context);
    
    
    
}



@end
