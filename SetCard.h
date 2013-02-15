//
//  SetCard.h
//  Matchismo
//
//  Created by Joel Derfner on 2/11/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) NSString *fill;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) int number;
@property (nonatomic, strong) NSAttributedString *attributedContents;

+(NSArray *)shapes;
+(NSArray *)fills;
+(NSArray *)colors;
+(NSArray *)nSNumbers;

@end
