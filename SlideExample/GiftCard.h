//
//  GiftCard.h
//  SlideExample
//
//  Created by Sahil Ishar on 9/24/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftCard : NSObject

+(id)sharedInstance;

@property (nonatomic, retain) NSMutableArray *cardArray;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *currentBalance;
@property (nonatomic, retain) UIImage *cardImage;

- (id)initWithName:(NSString *)aName number:(NSString *)aNumber currentBalance:(NSString *)aCurrentBalance cardImage:(UIImage *)aCardImage;

@end
