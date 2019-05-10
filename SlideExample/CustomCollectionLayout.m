//
//  CustomCollectionLayout.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/25/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CustomCollectionLayout.h"

@implementation CustomCollectionLayout

-(id)init{
    
    self = [super init];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    self.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 100.0);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumInteritemSpacing = 0;
}

-(CGSize)collectionViewContentSize
{
    NSInteger ySize = [self.collectionView numberOfItemsInSection:0] * (self.itemSize.height + 20.0);
    
    CGSize contentSize = CGSizeMake(self.collectionView.bounds.size.width, ySize);
    
    if (self.collectionView.bounds.size.width > contentSize.width)
        contentSize.width = self.collectionView.bounds.size.width;
    
    if (self.collectionView.bounds.size.height > contentSize.height)
        contentSize.height = self.collectionView.bounds.size.height;
    
    return contentSize;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    long numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray *attributesArray = [NSMutableArray array];
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    //Perform a deep copy of the attributes returned from super
    for (UICollectionViewLayoutAttributes *originalAttribute in originalAttributes) {
        [attributesArray addObject:[originalAttribute copy]];
    }
    
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        CGFloat xPosition = attributes.center.x;
        CGFloat yPosition = attributes.center.y;

        attributes.zIndex = numberOfItems + attributes.indexPath.row; //All cells appear tucked underneath the one above

        attributes.center = CGPointMake(xPosition, yPosition);
    }
    
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path] copy];
    
    return attributes;
}


@end
