//
//  TwoDirectionUISliderViewController.m
//  TwoDirectionUISlider
//
//  Created by Mahir Eusufzai on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwoDirectionUISliderViewController.h"

@implementation TwoDirectionUISliderViewController

@synthesize /*slider,*/ hLabel, vLabel;

- (void)dealloc
{
    [slider release];
    [hLabel release];
    [vLabel release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    slider = [[CrossSlider alloc] initWithFrame:CGRectMake(80, 90, 202, 76) hMinValue:7 hMaxValue:58 vMinValue:34 vMaxValue:78 currentHValue:10 currentVValue:38];
    
    
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllTouchEvents];

    [self.view addSubview:slider];
    hLabel.text = [NSString stringWithFormat: @"%d", (int)(slider.hValue)];
    vLabel.text = [NSString stringWithFormat: @"%d", (int)(slider.vValue)];
    

    
    [super viewDidLoad];

}


- (void)valueChanged:(CrossSlider *)crossSlider {
    
    hLabel.text = [NSString stringWithFormat: @"%d", (int)(crossSlider.hValue)];
    vLabel.text = [NSString stringWithFormat: @"%d", (int)(crossSlider.vValue)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    //self.slider = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
