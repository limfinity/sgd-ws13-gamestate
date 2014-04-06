//
//  SettingsScene.m
//  Fat.Finger
//
//  Created by Peter Pult on 08.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "SettingsScene.h"
#import "MyScene.h"

@interface SettingsScene ()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

- (void)goBack;

@end

@implementation SettingsScene

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        /* Setup your scene here */
        [self setBackgroundColor:[SKColor colorWithWhite:1 alpha:1]];
    }
    return self;
}

- (void)goBack
{
    SKScene *myScene = [[MyScene alloc] initWithSize:self.size];
    [self.view presentScene:myScene];
}

- (void)didMoveToView:(SKView *)view
{
    _closeBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _closeBtn.frame = CGRectMake(50, 50, 100, 100);
    [_closeBtn setTitle:@"Done" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn sizeToFit];
    
    [self.view addSubview:_closeBtn];
    
    GameStatsController *statsC = [GameStatsController defaultController];
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMidY(self.frame), self.frame.size.width - 100, 200)];
    _myLabel = tmpLabel;
    _myLabel.text = [NSString stringWithFormat:@"Current Level: %i\nGames Played: %i\nLoses: %i\nWins: %i", statsC.currentLevel, statsC.gamesPlayed, statsC.loses, statsC.wins];
    _myLabel.numberOfLines = 0;
    
    [self.view addSubview:_myLabel];
    
    _closeBtn.alpha = 1.0;
    _myLabel.alpha = 1.0;
}

- (void)willMoveFromView:(SKView *)view
{
    _closeBtn.alpha = 0.0;
    _myLabel.alpha = 0.0;
}

@end
