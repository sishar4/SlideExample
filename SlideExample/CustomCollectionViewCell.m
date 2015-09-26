//
//  CustomCollectionViewCell.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/26/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView setOpaque:YES];
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375.0, 237.0)];
        [_imgView setOpaque:YES];
        [_imgView setClipsToBounds:NO];
        
        [self.contentView addSubview:_imgView];
    }
    return self;
}

@end
