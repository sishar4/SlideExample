//
//  CardDetailView.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CardDetailView.h"

@implementation CardDetailView


- (IBAction)dismissButtonTapped:(id)sender
{
    void (^animateChangeHeight)() = ^()
    {
        //Notify ViewController that this view is being dismissed
        [[NSNotificationQueue defaultQueue] enqueueNotification:[NSNotification notificationWithName:@"ViewDismissedNotification" object:self] postingStyle:NSPostNow];
        
        //Set new frame for the view
        CGRect frame = CGRectMake(0, self.yPos, self.w, self.h);
        CGRect newFrame = frame;
        newFrame.size = frame.size;
        [self setFrame:newFrame];
    };
    
    // Animate
    [UIView transitionWithView:self duration:0.20f options: UIViewAnimationOptionCurveEaseIn animations:animateChangeHeight completion:^ (BOOL finished){
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
