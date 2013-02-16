//
//  SetCard.m
//  Matchismo
//
//  Created by Joel Derfner on 2/11/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards {
    SetCard *firstOtherCard = [otherCards objectAtIndex:0];
    SetCard *secondOtherCard = [otherCards objectAtIndex:1];
    if ([firstOtherCard.shape isEqualToString:secondOtherCard.shape]) {
        if (![self.shape isEqualToString:firstOtherCard.shape]) {
            NSLog(@"new card isn't equal to old cards");
            return 0;
        }
    } else {
        if ([self.shape isEqualToString:firstOtherCard.shape] || [self.shape isEqualToString:secondOtherCard.shape]) {
            NSLog(@"new card equals one of old cards");
            return 0;
        }
    }
    if ([firstOtherCard.fill isEqualToString:secondOtherCard.fill]) {
        if (![self.fill isEqualToString:firstOtherCard.fill]) {
            NSLog(@"Mismatch of fill");
            return 0;
        }
    } else {
        if ([self.fill isEqualToString:firstOtherCard.fill] || [self.fill isEqualToString:secondOtherCard.fill]) {
            NSLog(@"Mismatch of fill");
            return 0;
        }
    }
    if ([firstOtherCard.color isEqual:secondOtherCard.color]) {
        if (![self.color isEqual:firstOtherCard.color]) {
            NSLog(@"Mismatch of color");
            return 0;
        }
    } else {
        if ([self.color isEqual:firstOtherCard.color] || [self.color isEqual:secondOtherCard.color]) {
            NSLog(@"Mismatch of color");
            return 0;
        }
    }
    if (firstOtherCard.number == secondOtherCard.number) {
        if (self.number != firstOtherCard.number) {
            NSLog(@"new card isn't equal to old cards");
            NSLog(@"%d %d %d",self.number, firstOtherCard.number, secondOtherCard.number);
            return 0;
        }
    } else {
        if (self.number == firstOtherCard.number || self.number == secondOtherCard.number) {
            NSLog(@"new card equals one of old cards");
            NSLog(@"%d %d %d",self.number, firstOtherCard.number, secondOtherCard.number);
            return 0;
        }
    }
    NSLog(@"It's a match!");
    return 1;
}

+(NSArray *)shapes {
    return @[@"▲",@"●",@"■"];
}

+(NSArray *)colors {
    return @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]];
}

+(NSArray *)fills {
    //return @[@"outline",@"faint",@"full"];
    return @[@"outline"];
}

+(NSArray *)nSNumbers {
    return @[@1,@2,@3];
}

@end
