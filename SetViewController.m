//
//  SetViewController.m
//  Matchismo
//
//  Created by Joel Derfner on 2/11/13.
//  Copyright (c) 2013 Joel Derfner. All rights reserved.
//

#import "SetViewController.h"
#import "Card.h"
#import "Deck.h"
#import "SetCard.h"
#import "SetDeck.h"
#import "SetGame.h"

@interface SetViewController ()

@property (nonatomic, strong) SetGame *game;
@property (strong, nonatomic) Card *currentCard;
@property (strong, nonatomic) Card *lastCard;
@property (strong, nonatomic) Card *lastLastCard;
@property (nonatomic) int lastScore;
@property (weak, nonatomic) IBOutlet UILabel *labelFlip;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsForCards;
@property (strong, nonatomic) IBOutlet UILabel *messageToDisplay;
@property (weak, nonatomic) IBOutlet UILabel *labelForScore;
@property (strong, nonatomic) NSMutableArray *previousSets;
@property (weak, nonatomic) IBOutlet UISlider *sliderShowing;
@property (nonatomic) int flipCount;

- (IBAction)flipThroughHistory:(UISlider *)sender;

@end

@implementation SetViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.labelFlip.text = [NSString stringWithFormat:@"Flips: %d",flipCount];
}

-(void)setCardButtons:(NSArray *)cardButtons {
    _buttonsForCards = cardButtons;
    [self updateUI];
}

-(NSMutableArray *)previousMatches {
    if (!_previousSets) _previousSets = [[NSMutableArray alloc] init];
    return _previousSets;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(NSAttributedString *)attributeTitle:(SetCard *)card {
    NSString *shape = card.shape;
    if (card.number==2) shape = [shape stringByAppendingString:shape];
    if (card.number==3) shape = [shape stringByAppendingString:[shape stringByAppendingString:shape]];
    UIColor *color = card.color;
    UIColor *strokeColor;
    NSNumber *strokeWidth;
    if ([card.fill isEqualToString:@"outline"]) {
        color = [UIColor whiteColor];
        strokeWidth = @3.0;
    }
    else if ([card.fill isEqualToString:@"faint"]) {
        color = [color colorWithAlphaComponent:0.3];
        strokeWidth=@-3.0;
    }
    else if ([card.fill isEqualToString:@"full"]) {
        strokeWidth=@-3.0;
    }
    strokeColor = card.color;
    UIFont *font = [UIFont fontWithName:@"Georgia" size:12];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:shape attributes:@{NSForegroundColorAttributeName:color,NSStrokeColorAttributeName:strokeColor, NSStrokeWidthAttributeName:strokeWidth,NSFontAttributeName:font}];
    return string;
}

-(void)updateUI {
    for (UIButton *cardButton in self.buttonsForCards) {
        Card *card = [(SetGame *)self.game cardAtIndex:[self.buttonsForCards indexOfObject:cardButton]];
        SetCard *setCard = (SetCard *)card; //This ought to be protected against false.
        [cardButton setAttributedTitle:[self attributeTitle:setCard] forState:UIControlStateNormal];
        cardButton.selected = setCard.faceUp;
        if (setCard.faceUp) {
            cardButton.alpha=0.0;
        }
        [self.labelForScore setText:[NSString stringWithFormat:@"Score: %d",self.game.score]];
    }
    NSString *label = [self displayLabel];
    [self.messageToDisplay setText:label];
    [self.sliderShowing setMinimumValue:0.0];
    [self.sliderShowing setMaximumValue: (self.previousSets.count>1)? self.previousSets.count:1];
}

-(NSString *)displayLabel {
    NSString *message;
    NSString *addition;
    if (self.lastCard!=nil && self.lastLastCard!=nil) {
        message=[@[self.lastCard.contents, self.lastLastCard.contents] componentsJoinedByString:@" and "];
        message=[@[self.currentCard.contents,message] componentsJoinedByString:@", "];
        if ([self.currentCard match:@[self.lastCard, self.lastLastCard]]) {
            addition = [NSString stringWithFormat:@" match! %d points!",self.game.score-self.lastScore];
            self.lastCard=nil;
            self.lastLastCard=nil;
        } else if ([self.lastCard isEqual:self.currentCard]) {
            addition = [NSString stringWithFormat:@"--nice try, buddy. %d points.",self.game.score-self.lastScore];
        } else {
            addition = [NSString stringWithFormat:@" do not match. %d points.",self.game.score-self.lastScore];
            self.lastLastCard = self.lastCard;
        }
        message = [message stringByAppendingString:addition];
    } else if (self.lastCard!=nil) {
        message=[@[self.currentCard.contents,self.lastCard.contents] componentsJoinedByString:@" and "];
        self.lastLastCard = self.lastCard;
    } else {
        message = self.currentCard.contents;
    }
    self.lastCard = self.currentCard;
    self.lastScore = self.game.score;
    return message;
}

-(IBAction)makeANewGame:(id)sender {
    NSLog(@"New set game.");
    _game = nil;
    self.currentCard=nil;
    self.lastCard=nil;
    self.lastScore=nil;
    self.lastLastCard=nil;
    [self.messageToDisplay setText:nil];
    [self game];
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)flipThisCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.buttonsForCards indexOfObject:sender]];
    self.currentCard = [self.game cardAtIndex:[self.buttonsForCards indexOfObject:sender]];
    self.flipCount++;
    if (self.messageToDisplay.text) {
        [self.previousSets addObject:self.messageToDisplay.text];
    }
    self.sliderShowing.value=self.previousSets.count;
    [self updateUI];
}

- (IBAction)flipThroughHistory:(UISlider *)sender {
    int currentIndex = roundf(sender.value);
    if (currentIndex<self.previousSets.count) {
        self.messageToDisplay.alpha=0.3;
    } else {
        self.messageToDisplay.alpha=1;
    }
    [self updateUI];
}

-(void)viewDidAppear:(BOOL)animated {
    if (!_game) _game = [[SetGame alloc] initWithCardCount:[self.buttonsForCards count] usingDeck:[[SetDeck alloc] init]];
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
