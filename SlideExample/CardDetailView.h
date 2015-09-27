//
//  CardDetailView.h
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDetailView : UIView

@property (nonatomic, assign) float yPos;
@property (nonatomic, assign) float w;
@property (nonatomic, assign) float h;

@property (nonatomic, weak) IBOutlet UIButton *dismissButton;
@property (nonatomic, weak) IBOutlet UIImageView *cardImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *numberLbl;
@property (nonatomic, weak) IBOutlet UILabel *balanceLbl;

- (IBAction)dismissButtonTapped:(id)sender;

@end
