//
//  SetDeck.m
//  Matchismo
//
//  Created by Joel Derfner on 2/11/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

-(id)init {
    self = [super init];
    if (self) {
        for (NSString *shape in [SetCard shapes]) {
            for (NSString *fill in [SetCard fills]) {
                for (UIColor *color in [SetCard colors]) {
                    for (NSNumber *number in [SetCard nSNumbers]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.fill = fill;
                        card.color = color;
                        card.number = [number integerValue];
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
