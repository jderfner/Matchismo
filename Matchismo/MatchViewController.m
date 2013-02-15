//
//  MatchViewController.m
//  Matchismo
//
//  Created by Joel Derfner on 1/28/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "MatchViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface MatchViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) Card *currentCard;
@property (strong, nonatomic) Card *lastCard;
@property (strong, nonatomic) Card *lastLastCard;
@property (nonatomic) int lastScore;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray *previousMatches;
@property (weak, nonatomic) IBOutlet UISlider *sliderOutlet;

- (IBAction)flipCard:(UIButton *)sender;

@end

@implementation MatchViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",flipCount];
}

-(void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        if (card.faceUp) {
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        else {
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
        }
        cardButton.selected = card.faceUp;
        cardButton.alpha=(card.unplayable ? 0.3:1.0);
        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d",self.game.score]];
    }
    NSString *label = [self displayLabel];
    [self.message setText:label];
    [self.sliderOutlet setMinimumValue:0.0];
    [self.sliderOutlet setMaximumValue: (self.previousMatches.count>1)? self.previousMatches.count:1];
}

-(NSMutableArray *)previousMatches {
    if (!_previousMatches) _previousMatches = [[NSMutableArray alloc] init];
    return _previousMatches;
}

-(NSString *)displayLabel {
    NSString *message;
    NSString *addition;
    if (self.sliderOutlet.value>=self.sliderOutlet.maximumValue-1) { //THIS ISN'T RIGHT YET.
        if (self.lastCard!=nil) {
            message=[@[self.currentCard.contents, self.lastCard.contents] componentsJoinedByString:@" and "];
            if ([self.currentCard match:@[self.lastCard]]) {
                addition = [NSString stringWithFormat:@" match! %d points!",self.game.score-self.lastScore];
                self.lastCard=nil;
            } else if ([self.lastCard isEqual:self.currentCard]) {
                addition = [NSString stringWithFormat:@"--nice try, buddy. %d points.",self.game.score-self.lastScore];
            } else {
                addition = [NSString stringWithFormat:@" do not match. %d points.",self.game.score-self.lastScore];
                self.lastCard=self.currentCard;
            }
            message = [message stringByAppendingString:addition];
        } else {
            message=[NSString stringWithFormat:@"%@",self.currentCard.contents];
            self.lastCard=self.currentCard;
            self.message.alpha=1;
        }
    } else {
        int index = (roundf(self.sliderOutlet.value-1)<0) ? 0:roundf(self.sliderOutlet.value-1);
        if (self.previousMatches[index])
        message = self.previousMatches[index];
    }
    NSLog(@"score change: %d",self.game.score-self.lastScore);
    self.lastScore = self.game.score;
    NSLog(@"slider value: %f, previous matches: %d",roundf(self.sliderOutlet.value),self.previousMatches.count);
    return message;
}

- (IBAction)flipCard:(UIButton *)sender {
    NSLog(@"Flipping card");
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.currentCard = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    if (self.message.text) {
        [self.previousMatches addObject:self.message.text];
    }
    self.sliderOutlet.value=self.previousMatches.count;
    [self updateUI];
}

- (IBAction)newGame:(id)sender {
    NSLog(@"New game.");
    self.currentCard=nil;
    self.lastCard=nil;
    self.lastScore=nil;
    self.lastLastCard=nil;
    [self.message setText:nil];
    [self game];
    [self updateUI];
}

- (IBAction)goThroughHistory:(UISlider *)sender {
    int currentIndex = roundf(sender.value);
    if (currentIndex<self.previousMatches.count) {
        self.message.alpha=0.3;
    } else {
        self.message.alpha=1;
    }
    [self updateUI];
}

-(void)viewDidLoad {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
}

@end
