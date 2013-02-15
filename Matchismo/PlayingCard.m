//
//  PlayingCard.m
//  Matchismo
//
//  Created by Joel Derfner on 1/28/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count]==1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            if (![self isEqual:otherCard]) {
                if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                    score+=1;
                } else if (otherPlayingCard.rank == self.rank) {
                    score+=4;
                }
            }
        }
    } else if ([otherCards count]==2) {
        PlayingCard *firstOtherCard = [otherCards objectAtIndex:0];
        PlayingCard *secondOtherCard = [otherCards objectAtIndex:1];
        if (![self isEqual:firstOtherCard] && ![self isEqual:secondOtherCard]) {
            if ([self.suit isEqualToString:firstOtherCard.suit] && [self.suit isEqualToString:secondOtherCard.suit]) {
                score+=2;
            } else if (self.rank == firstOtherCard.rank && self.rank == secondOtherCard.rank) {
                score+=8;
            }
        }
    }
    return score;
}

-(NSString *)contents {
    NSArray *rankStrings =  [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSArray *)validSuits {
    return @[@"♠",@"♣",@"♥",@"♦"];
}
-(void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *)suit {
    return _suit ? _suit : @"?";
}
+(NSUInteger)maxRank {
    return [self rankStrings].count-1;
}
- (void)setRank:(NSUInteger)rank {
    if (rank<=[PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
