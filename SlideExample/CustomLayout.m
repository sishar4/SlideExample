//
//  CustomLayout.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/25/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "CustomLayout.h"

@implementation CustomLayout

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
    self.itemSize = ITEM_SIZE;
    
    //set minimum layout requirements
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumInteritemSpacing = 0;
}

-(CGSize)collectionViewContentSize
{
    NSInteger xSize = [self.collectionView numberOfItemsInSection:0]
    * self.itemSize.width;
    NSInteger ySize = [self.collectionView numberOfSections]
    * (self.itemSize.height);
    
    CGSize contentSize = CGSizeMake(xSize, ySize);
    
    if (self.collectionView.bounds.size.width > contentSize.width)
        contentSize.width = self.collectionView.bounds.size.width;
    
    if (self.collectionView.bounds.size.height > contentSize.height)
        contentSize.height = self.collectionView.bounds.size.height;
    
    return contentSize;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* attributesArray = [super layoutAttributesForElementsInRect:rect];
    int numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        CGFloat xPosition = attributes.center.x;
        CGFloat yPosition = attributes.center.y;
        
        if (attributes.indexPath.row == 0) {
            attributes.zIndex = INT_MAX; // Put the first cell on top of the stack
        } else {
            yPosition -= STACK_OVERLAP * attributes.indexPath.row;
            attributes.zIndex = numberOfItems - attributes.indexPath.row; //Other cells below the first one
        }
        
        attributes.center = CGPointMake(xPosition, yPosition);
    }
    
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path {
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    return attributes;
}

@end
