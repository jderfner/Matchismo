//
//  SetGame.m
//  Matchismo
//
//  Created by Joel Derfner on 2/11/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "SetGame.h"

@interface SetGame ()

@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cardsToCheckAgainst;

@end

@implementation SetGame

-(SetCard *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

-(NSMutableArray *)cardsToCheckAgainst {
    if (!_cardsToCheckAgainst) _cardsToCheckAgainst = [[NSMutableArray alloc] initWithCapacity:2];
    return _cardsToCheckAgainst;
}

#define MATCH_BONUS 4
#define FLIP_COST 1
-(void)flipCardAtIndex:(NSUInteger)index {
    Card *pickedCard = [self cardAtIndex:index];
    SetCard *card = (SetCard *)pickedCard;
    NSLog(@"%@ %d %@",card.shape, card.number, card.fill);
    if (card && !card.unplayable) {
        if (!card.faceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.faceUp && !otherCard.unplayable && otherCard!=card) {
                    if (self.cardsToCheckAgainst.count<=1) { //This protects against there being more than 2 cards in cardsToCheckAgainst.count (i.e., against it being a four-match game).
                        [self.cardsToCheckAgainst addObject:otherCard];
                    }
                        NSLog(@"cards to check against:  %d",self.cardsToCheckAgainst.count);
                }
            }
            if (self.cardsToCheckAgainst.count==2) {
                int matchScore = [card match:self.cardsToCheckAgainst];
                NSLog(@"score: %d",matchScore);
                if (matchScore) {
                    card.unplayable=YES;
                    for (Card *c in self.cardsToCheckAgainst) {
                        c.unplayable=YES;
                    }
                    self.score+=matchScore*MATCH_BONUS;
                    self.score+=1; //to counteract flip cost.
                }
                else {
                    for (Card *c in self.cardsToCheckAgainst) {
                        c.faceUp=NO;
                        self.score-=FLIP_COST;
                    }
                }
            } 
        }
    }
    card.faceUp=!card.faceUp;
    NSLog(@"score: %d",self.score);
    if (self.cardsToCheckAgainst.count==2) {
        self.cardsToCheckAgainst = nil; 
        self.cardsToCheckAgainst = [[NSMutableArray alloc] initWithCapacity:2];
    }
}

@end
