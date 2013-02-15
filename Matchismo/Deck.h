//
//  Deck.h
//  Matchismo
//
//  Created by Joel Derfner on 1/28/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(Card *)drawRandomCard;

@end
