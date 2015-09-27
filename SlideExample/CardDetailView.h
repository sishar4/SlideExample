//
//  CardDetailView.h
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDetailView : UIView

@property (nonatomic, weak) IBOutlet UIButton *dismissButton;

- (IBAction)dismissButtonTapped:(id)sender;

@end
