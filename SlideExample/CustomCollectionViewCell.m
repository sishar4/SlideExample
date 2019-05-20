//
//  CustomCollectionViewCell.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView setOpaque:YES];
        
        float multiplier = self.contentView.bounds.size.width/375.0;
        float resizedHeight = ceilf(multiplier * 237.0);
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, resizedHeight)];
        [_imgView setOpaque:YES];
        [_imgView setClipsToBounds:YES];
        
        [self.contentView addSubview:_imgView];
    }
    return self;
}

- (void)configureWithCard:(id)card andImage:(UIImage *)cardImage {
    
    // Add rounded corners to image
    UIGraphicsBeginImageContextWithOptions(cardImage.size, NO, cardImage.scale);
    CGRect rect = CGRectMake(16, 0, cardImage.size.width - 32, cardImage.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cardImage.size.width/32] addClip];
    [cardImage drawInRect:rect];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imgView.image = roundedImage;
    
    //Add light drop shadow on cell
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowRadius = 8.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
}

@end
