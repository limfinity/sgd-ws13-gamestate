//
//  MyScene.m
//  Fat.Finger
//
//  Created by Peter Pult on 06.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "MyScene.h"
#import "GameScene.h"
#import "SettingsScene.h"

@interface MyScene ()

@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;

- (void)startGame;
- (void)openSettings;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    self = [super initWithSize:size];
    if (self) {
        /* Setup your scene here */
        [self setBackgroundColor:[SKColor colorWithWhite:1 alpha:1]];
    }
    
    return self;
}

- (void)startGame
{
    SKScene *gameScene = [[GameScene alloc] initWithSize:self.size];
    [self.view presentScene:gameScene];
}

- (void)openSettings
{
    SKScene *settingsScene = [[SettingsScene alloc] initWithSize:self.size];
    [self.view presentScene:settingsScene];
}

- (void)didMoveToView:(SKView *)view
{
    _startBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _startBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame)-50, CGRectGetMidY(self.view.frame)-115, 100, 100);
    [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
    [_startBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    _startBtn.layer.cornerRadius = 50;//half of the width
    _startBtn.layer.borderColor=[UIColor darkGrayColor].CGColor;
    _startBtn.layer.borderWidth=2.0f;
    
    [self.view addSubview:_startBtn];
    
    _settingsBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _settingsBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame)-50, CGRectGetMidY(self.view.frame)+15, 100, 100);
    [_settingsBtn setTitle:@"Statistics" forState:UIControlStateNormal];
    [_settingsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_settingsBtn addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    
    _settingsBtn.layer.cornerRadius = 50;//half of the width
    _settingsBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _settingsBtn.layer.borderWidth=2.0f;
    
    [self.view addSubview:_settingsBtn];
    
    _startBtn.alpha = 1.0;
    _settingsBtn.alpha = 1.0;
}

- (void)willMoveFromView:(SKView *)view
{
    _startBtn.alpha = 0.0;
    _settingsBtn.alpha = 0.0;
}

@end
