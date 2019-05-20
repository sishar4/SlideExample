//
//  GiftCard.h
//  SlideExample
//
//  Created by Sahil Ishar on 9/24/15.
//  Copyright © 2015 Sahil Ishar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GiftCard : NSObject

@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *currentBalance;
@property (nonatomic, strong) UIImage *cardImage;

- (id)initWithName:(NSString *)aName number:(NSString *)aNumber currentBalance:(NSString *)aCurrentBalance cardImage:(UIImage *)aCardImage;

@end
