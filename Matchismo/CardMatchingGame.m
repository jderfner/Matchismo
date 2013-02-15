//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Joel Derfner on 1/31/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSString *result;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define FLIP_COST 1
-(void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (card && !card.unplayable) {
        if (!card.faceUp) { //necessary so card doesn't check against itself?
            for (Card *otherCard in self.cards) {
                if (otherCard.faceUp && !otherCard.unplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable=YES;
                        otherCard.unplayable=YES;
                        self.score+=matchScore*MATCH_BONUS;
                    }
                    else {
                        otherCard.faceUp=NO;
                        self.score-=FLIP_COST;
                        break;
                    }
                }
            }
        }
        card.faceUp=!card.faceUp;
    }
}

-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i]=card;
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end
