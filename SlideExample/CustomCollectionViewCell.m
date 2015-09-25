//
//  CustomCollectionViewCell.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/25/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "CustomCellContentView.h"

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:[[CustomCellContentView alloc] initWithFrame:self.contentView.bounds]];
    }
    
    return self;
}


@end
