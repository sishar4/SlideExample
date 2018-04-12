//
//  GiftCard.m
//  SlideExample
//
//  Created by Sahil Ishar on 9/24/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import "GiftCard.h"

@implementation GiftCard

+ (id)sharedInstance
{
    static GiftCard *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.cardArray = [[NSMutableArray alloc] init];
    });
    
    return sharedInstance;
}

- (id)initWithName:(NSString *)aName number:(NSString *)aNumber currentBalance:(NSString *)aCurrentBalance cardImage:(UIImage *)aCardImage
{
    if (self = [super init]) {
        self.name = aName;
        self.number = aNumber;
        self.currentBalance = aCurrentBalance;
        self.cardImage = aCardImage;
    }
    
    return self;
}

@end
