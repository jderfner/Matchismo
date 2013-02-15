//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Joel Derfner on 1/31/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;
@property (nonatomic, strong) NSMutableArray *cards;

            //designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@end
