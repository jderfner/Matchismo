//
//  Card.h
//  Matchismo
//
//  Created by Joel Derfner on 1/28/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL unplayable;
@property (nonatomic) BOOL partOfMatch;

-(int)match:(NSArray *)otherCards;

@end
