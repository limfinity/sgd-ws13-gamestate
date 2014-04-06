//
//  GameScene.m
//  Fat.Finger
//
//  Created by Peter Pult on 06.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "GameScene.h"
#import "EndScene.h"
#import "UIColor+LightAndDark.h"

@interface GameScene () {
    SKShapeNode *rndBtn;
}

- (UIColor *)randomColor;

@end

@implementation GameScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        /* Setup your scene here */
        [self setBackgroundColor:[SKColor clearColor]];
        UIColor *rndColor = self.randomColor;
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:rndColor size:size];
        [self addChild:bg];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        int level = [[GameStatsController defaultController] currentLevel];
        if (level > 20) {
            level = 20;
        }
        CGSize btnSize = CGSizeMake(100, 100);
        btnSize.width = btnSize.width * powf(0.8f, (float)level);
        btnSize.height = btnSize.width;
        rndBtn = [[SKShapeNode alloc] init];
        rndBtn.path = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, btnSize.width, btnSize.height), NULL);
        [self addChild:rndBtn];
        rndBtn.position = CGPointMake(CGRectGetMidX(self.frame) - btnSize.width / 2, CGRectGetMidY(self.frame) - btnSize.width / 2);
        rndBtn.lineWidth = 0.1f;
        rndBtn.glowWidth = 0;
        rndBtn.fillColor = [rndColor darkerColor];
        rndBtn.strokeColor = [SKColor whiteColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    BOOL hit = NO;
    for (UITouch *touch in touches) {
        NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
        for (SKNode *node in nodes) {
            if ([node isEqual:rndBtn]) {
                hit = YES;
            }
        }
    }
    
    SKScene *endScene = [[EndScene alloc] initWithSize:self.size andSuccess:hit];
    [self.view presentScene:endScene];
    
}

- (void)willMoveFromView:(SKView *)view
{
    [rndBtn removeFromParent];
}

- (UIColor *)randomColor
{
    /* 
     * Credits go to: kylefox
     * https://gist.github.com/kylefox/1689973
     */
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


@end
