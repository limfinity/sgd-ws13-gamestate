//
//  EndScene.m
//  Fat.Finger
//
//  Created by Peter Pult on 07.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "EndScene.h"
#import "GameScene.h"
#import "MyScene.h"

@interface EndScene ()

@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (assign, nonatomic) BOOL success;

- (void)goToHome;
- (void)continueGame;

@end

@implementation EndScene

- (id)initWithSize:(CGSize)size andSuccess:(BOOL)success {
    self = [super initWithSize:size];
    if (self) {
        /* Setup your scene here */
        [self setBackgroundColor:[SKColor whiteColor]];
        
        self.success = success;
        
        GameStatsController *statsC = [GameStatsController defaultController];
        
        statsC.gamesPlayed++;
        if (self.success) {
            statsC.currentLevel++;
            statsC.wins++;
        } else {
            statsC.currentLevel = 1;
            statsC.loses++;
        }
        NSDictionary *statsD = @{
                                     @"Current Level" : @(statsC.currentLevel),
                                     @"Games Played" : @(statsC.gamesPlayed),
                                     @"Loses" : @(statsC.loses),
                                     @"Wins" : @(statsC.wins)
                                     };

        [[GameStatsController defaultController] updatePropertiesWithDict:statsD];

        SKLabelNode *myLabel = [[SKLabelNode alloc] init];
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 90);
        if (self.success) {
            [myLabel setFontColor:[SKColor greenColor]];
            myLabel.text = @"Great job! Try the next level.";
        } else {
            [myLabel setFontColor:[SKColor redColor]];
            myLabel.text = @"Whoops! Try again.";
        }
        [self addChild:myLabel];

    }
    
    return self;
}

- (void)continueGame
{
    SKScene *gameScene = [[GameScene alloc] initWithSize:self.size];
    [self.view presentScene:gameScene];
}

- (void)goToHome
{
    SKScene *homeScene = [[MyScene alloc] initWithSize:self.size];
    [self.view presentScene:homeScene];
}

- (void)didMoveToView:(SKView *)view
{
    if (_continueBtn == nil) {
        self.continueBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    _continueBtn.frame = CGRectMake(CGRectGetMidX(self.frame)-50, CGRectGetMidY(self.frame)-115, 100, 100);
    if (self.success) {
        [_continueBtn setTitle:@"Next Level" forState:UIControlStateNormal];
    } else {
        [_continueBtn setTitle:@"Start New" forState:UIControlStateNormal];
    }
    [_continueBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_continueBtn addTarget:self action:@selector(continueGame) forControlEvents:UIControlEventTouchUpInside];
    
    _continueBtn.layer.cornerRadius = 50;//half of the width
    _continueBtn.layer.borderColor=[UIColor darkGrayColor].CGColor;
    _continueBtn.layer.borderWidth=2.0f;
    
    [self.view addSubview:_continueBtn];
    
    if (_homeBtn == nil) {
        self.homeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    _homeBtn.frame = CGRectMake(CGRectGetMidX(self.frame)-50, CGRectGetMidY(self.frame)+15, 100, 100);
    [_homeBtn setTitle:@"Go Home" forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
    
    _homeBtn.layer.cornerRadius = 50;//half of the width
    _homeBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _homeBtn.layer.borderWidth=2.0f;
    
    [self.view addSubview:_homeBtn];
    
    _continueBtn.alpha = 1.0;
    _homeBtn.alpha = 1.0;
     
}

- (void)willMoveFromView:(SKView *)view
{
    if (_continueBtn != nil) {
        _continueBtn.alpha = 0.0;
    }
    
    if (_homeBtn != nil) {
        _homeBtn.alpha = 0.0;
    }
}

@end
