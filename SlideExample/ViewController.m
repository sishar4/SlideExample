//
//  ViewController.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/24/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "ViewController.h"
#import "GiftCard.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAGradientLayer.h>
#import <QuartzCore/CAShapeLayer.h>

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *giftCardArray;
@end

@implementation ViewController

+ (void)roundedImage:(UIImage *)image
          completion:(void (^)(UIImage *image))completion {
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:image.size.width/2] addClip];
        [image drawInRect:rect];
        UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Lets forget about that we were drawing
        UIGraphicsEndImageContext();
        dispatch_async( dispatch_get_main_queue(), ^{
            if (completion) {
                completion(roundedImage);
            }
        });
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [_collectionView setClearsContextBeforeDrawing:NO];
    
    //Retrieve User's gift cards in bg thread
    //then update table view
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
        
        GiftCard *sharedObj = [GiftCard sharedInstance];
        [sharedObj.cardArray addObjectsFromArray:self.giftCardArray];
        
        //Adjust images
        for (GiftCard *gc in self.giftCardArray) {

            UIGraphicsBeginImageContextWithOptions(gc.cardImage.size, NO, gc.cardImage.scale);
            CGRect rect = CGRectMake(0, 0, gc.cardImage.size.width, gc.cardImage.size.height);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:gc.cardImage.size.width/32] addClip];
            [gc.cardImage drawInRect:rect];
            UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            gc.cardImage = roundedImage;
        }

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    GiftCard *card = [self.giftCardArray objectAtIndex:indexPath.row];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375.0, 237.0)];
    imgView.opaque = YES;
    imgView.image = card.cardImage;
    
    [cell.contentView addSubview:imgView];
    cell.contentView.opaque = YES;
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.shouldRasterize = YES;
    cell.layer.opaque = YES;
    
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    cell.layer.shadowRadius = 5.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    return cell;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
