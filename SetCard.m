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
            return 0;
        }
    } else {
        if ([self.shape isEqualToString:firstOtherCard.shape] || [self.shape isEqualToString:secondOtherCard.shape]) {
            return 0;
        }
    }
    if ([firstOtherCard.fill isEqualToString:secondOtherCard.fill]) {
        if (![self.fill isEqualToString:firstOtherCard.fill]) {
            return 0;
        }
    } else {
        if ([self.fill isEqualToString:firstOtherCard.fill] || [self.fill isEqualToString:secondOtherCard.fill]) {
            return 0;
        }
    }
    if ([firstOtherCard.color isEqual:secondOtherCard.color]) {
        if (![self.color isEqual:firstOtherCard.color]) {
            return 0;
        }
    } else {
        if ([self.color isEqual:firstOtherCard.color] || [self.color isEqual:secondOtherCard.color]) {
            return 0;
        }
    }
    if (firstOtherCard.number == secondOtherCard.number) {
        if (self.number != firstOtherCard.number) {
            return 0;
        }
    } else {
        if (self.number == firstOtherCard.number || self.number == secondOtherCard.number) {
            return 0;
        }
    }
    return 1;
}

+(NSArray *)shapes {
    return @[@"▲",@"●",@"■"];
}

+(NSArray *)colors {
    return @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]];
}

+(NSArray *)fills {
    return @[@"outline",@"faint",@"full"];
}

+(NSArray *)nSNumbers {
    return @[@1,@2,@3];
}

@end
