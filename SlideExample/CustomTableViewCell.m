//
//  CustomTableViewCell.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/25/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CustomCellContentView.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:[[CustomCellContentView alloc] initWithFrame:self.contentView.bounds]];
    }
    
    return self;
}

@end
