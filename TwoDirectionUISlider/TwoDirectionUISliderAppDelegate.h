//
//  TwoDirectionUISliderAppDelegate.h
//  TwoDirectionUISlider
//
//  Created by Mahir Eusufzai on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwoDirectionUISliderViewController;

@interface TwoDirectionUISliderAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TwoDirectionUISliderViewController *viewController;

@end
