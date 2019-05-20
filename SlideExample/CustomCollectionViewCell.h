//
//  CustomCollectionViewCell.h
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftCard.h"

@interface CustomCollectionViewCell : UICollectionViewCell

- (void)configureWithCard:(GiftCard *)card andImage:(UIImage *)cardImage;
@end
