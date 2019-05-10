//
//  CardDetailView.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CardDetailView.h"

@implementation CardDetailView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.cardImage.layer.shouldRasterize = YES;
    [self.layer setOpaque:YES];
    self.layer.shouldRasterize = YES;
    
    UIGraphicsBeginImageContextWithOptions(self.cardImage.image.size, NO, self.cardImage.image.scale);
    CGRect cardImageRect = CGRectMake(0, 0, self.cardImage.image.size.width, self.cardImage.image
                                      .size.height);
    [[UIBezierPath bezierPathWithRoundedRect:cardImageRect cornerRadius:self.cardImage.image.size.width/32] addClip];
    [self.cardImage.image drawInRect:cardImageRect];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.cardImage.image = roundedImage;
    
    //Add light drop shadow on cell
    self.cardImage.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.cardImage.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.cardImage.layer.shadowRadius = 8.0f;
    self.cardImage.layer.shadowOpacity = 1.0f;
    self.cardImage.layer.masksToBounds = NO;
    self.cardImage.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.cardImage.bounds cornerRadius:self.cardImage.layer.cornerRadius].CGPath;
    
    [self.cardImage setOpaque:YES];
}

- (IBAction)dismissButtonTapped:(id)sender
{
    void (^animateChangeHeight)() = ^()
    {
        //Set new frame for the view
        CGRect frame = CGRectMake(0, self.yPos + 72.0, self.w, self.h);
        [self setFrame:frame];
        self.cardImage.alpha = 0.25;
    };
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.containerView removeFromSuperview];
    
    // Animate
    [UIView transitionWithView:self duration:0.20f options: UIViewAnimationOptionCurveEaseOut animations:animateChangeHeight completion:^ (BOOL finished) {
        if (finished) {
            self.cardImage.alpha = 0;
            [self removeFromSuperview];
        }
    }];
}

- (void)showDetailView {
    self.containerView.alpha = 1;
}

- (void)hideDetailView {
    self.containerView.alpha = 0;
}

@end
