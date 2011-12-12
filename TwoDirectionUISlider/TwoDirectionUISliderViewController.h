//
//  TwoDirectionUISliderViewController.h
//  TwoDirectionUISlider
//
//  Created by Mahir Eusufzai on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrossSlider.h"

@interface TwoDirectionUISliderViewController : UIViewController {
    
    CrossSlider *slider;
    
    UILabel *hLabel;
    UILabel *vLabel;
    
}

//@property (nonatomic, retain) IBOutlet CrossSlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *hLabel;
@property (nonatomic, retain) IBOutlet UILabel *vLabel;

- (void) valueChanged:(CrossSlider *) crossSlider;
@end

