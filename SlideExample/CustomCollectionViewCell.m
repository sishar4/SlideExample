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
        _imgView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [_imgView setOpaque:YES];
        [self.contentView addSubview:_imgView];
    }
    return self;
}

@end
