//
//  ViewController.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/24/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "ViewController.h"
#import "GiftCard.h"
#import "CustomCollectionViewCell.h"
#import "CardDetailView.h"
#import "AppDelegate.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAGradientLayer.h>
#import <QuartzCore/CAShapeLayer.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *giftCardArray;
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic) BOOL didClickOnCardDetails;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_collectionView reloadData];
}

- (void)viewDidLayoutSubviews {
    // Don't resize subviews when card details list is shown or hidden, only when view first loads
    if (!self.didClickOnCardDetails) {
        float multiplier = [[UIScreen mainScreen] bounds].size.width/375.0;
        float resizedHeight = ceilf(multiplier * 223.0);
        self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height + (resizedHeight - 100.0);  // Adds padding for size of card image minus size of the cell, to account for final card in list
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"customCell"];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"MCSRCiCollectionViewSupplementaryView"];
    self.imageCache = [[NSCache alloc] init];
    
    //Retrieve User's gift cards in bg thread
    //then update collection view
    //For this example, the images were already given in Resources folder
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        GiftCard *card1 = [[GiftCard alloc] initWithName:@"Burger King" number:@"1234" currentBalance:@"0.00" cardImage:[UIImage imageNamed:@"bk.png"]];
        GiftCard *card2 = [[GiftCard alloc] initWithName:@"Bloomindale's" number:@"1574" currentBalance:@"10.00" cardImage:[UIImage imageNamed:@"bloomies.png"]];
        GiftCard *card3 = [[GiftCard alloc] initWithName:@"Home Depot" number:@"1798" currentBalance:@"25.00" cardImage:[UIImage imageNamed:@"homedepot.png"]];
        GiftCard *card4 = [[GiftCard alloc] initWithName:@"Macy's" number:@"2563" currentBalance:@"0.50" cardImage:[UIImage imageNamed:@"macys.png"]];
        GiftCard *card5 = [[GiftCard alloc] initWithName:@"Nike" number:@"9084" currentBalance:@"1.00" cardImage:[UIImage imageNamed:@"nike.png"]];
        GiftCard *card6 = [[GiftCard alloc] initWithName:@"Old Navy" number:@"3324" currentBalance:@"100.00" cardImage:[UIImage imageNamed:@"oldnavy.png"]];
        GiftCard *card7 = [[GiftCard alloc] initWithName:@"Starbucks" number:@"1676" currentBalance:@"7.50" cardImage:[UIImage imageNamed:@"starbucks.png"]];
        GiftCard *card8 = [[GiftCard alloc] initWithName:@"Subway" number:@"1738" currentBalance:@"0.00" cardImage:[UIImage imageNamed:@"subway.png"]];
        GiftCard *card9 = [[GiftCard alloc] initWithName:@"The Container Store" number:@"1816" currentBalance:@"25.00" cardImage:[UIImage imageNamed:@"tcs.png"]];
        GiftCard *card10 = [[GiftCard alloc] initWithName:@"Trader Joe's" number:@"9113" currentBalance:@"50.00" cardImage:[UIImage imageNamed:@"tj.png"]];
        GiftCard *card11 = [[GiftCard alloc] initWithName:@"Walmart" number:@"5534" currentBalance:@"50.00" cardImage:[UIImage imageNamed:@"walmart.png"]];
        GiftCard *card12 = [[GiftCard alloc] initWithName:@"Whole Foods" number:@"6798" currentBalance:@"8.00" cardImage:[UIImage imageNamed:@"wholefoods.png"]];
        
        self.giftCardArray = [[NSMutableArray alloc] initWithObjects:card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, nil];

        dispatch_async( dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
    });
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [self.giftCardArray count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    
    [cell setClearsContextBeforeDrawing:NO];
    [cell.layer setOpaque:YES];
    [cell setOpaque:YES];
    cell.layer.shouldRasterize = YES;
    cell.contentView.layer.shouldRasterize = YES;
    
    GiftCard *card = [self.giftCardArray objectAtIndex:indexPath.row];

    UIImage *cachedCardImage = [self.imageCache objectForKey:card.name];
    
    if (cachedCardImage != nil) {
        // Use cached image if it exists
        [cell configureWithCard:card andImage:cachedCardImage];
    } else {
        // Else, download the image first, here just fetching locally
        UIImage *cardImage = card.cardImage;
        [self.imageCache setObject:cardImage forKey:card.name];
        
        [cell configureWithCard:card andImage:cardImage];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.didClickOnCardDetails = YES;
    GiftCard *giftCard = [self.giftCardArray objectAtIndex:indexPath.row];

    //Frame of selected cell
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellRect = attributes.frame;
    CGRect cellFrameInSuperview = [collectionView convertRect:cellRect toView:[collectionView superview]];
    cellFrameInSuperview.origin.y = cellFrameInSuperview.origin.y - 72.0;

    //Create view with card detail info
    //in the initial frame of selected cell
    CardDetailView *cardDetailView = [[[NSBundle mainBundle] loadNibNamed:@"CardDetailView" owner:self options:nil] objectAtIndex:0];
    [cardDetailView setFrame:cellFrameInSuperview];
    [cardDetailView setYPos:cellFrameInSuperview.origin.y - 72.0];
    [cardDetailView setW:cellFrameInSuperview.size.width];
    [cardDetailView setH:cellFrameInSuperview.size.height];
    
    //Re-size image to keep retina quality for different screen sizes
    float multiplier = [[UIScreen mainScreen] bounds].size.width/375.0;
    float resizedHeight = ceilf(multiplier * 237.0);
    [cardDetailView.cardImage setImage:giftCard.cardImage];
    [cardDetailView.imageHeightConstraint setConstant:resizedHeight];
    
    [cardDetailView.nameLbl setText:[NSString stringWithFormat:@"%@ Gift Card", giftCard.name]];
    [cardDetailView.numberLbl setText:[NSString stringWithFormat:@"**** %@", giftCard.number]];
    [cardDetailView.balanceLbl setText:[NSString stringWithFormat:@"$%@", giftCard.currentBalance]];
    
    // Add as subview
    [cardDetailView setBackgroundColor:[UIColor clearColor]];
    [cardDetailView hideDetailView];
    [self.view addSubview:cardDetailView];
    
    void (^animateChangeHeight)() = ^()
    {
        //Set new frame for the view
        CGRect newFrame = self.view.frame;
        [cardDetailView setFrame:newFrame];
        [cardDetailView showDetailView];
    };
    
    // Animate
    [UIView transitionWithView:cardDetailView duration:0.20f options: UIViewAnimationOptionCurveEaseIn animations:animateChangeHeight completion:^ (BOOL finished) {
        if (finished) {
            [cardDetailView setBackgroundColor:[UIColor whiteColor]];
        }
    }];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *customView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"MCSRCiCollectionViewSupplementaryView"
                                                                                     forIndexPath:indexPath];
    
    if (kind == UICollectionElementKindSectionHeader) {
        self.headerView.frame = customView.frame;
        [customView addSubview:self.headerView];
    }
    
    return customView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.imageCache = nil;
}

@end
