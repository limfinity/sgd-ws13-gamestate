//
//  GameStatsController.m
//  Fat.Finger
//
//  Description:
//  Class to handle all the game stats.
//
//  Created by Peter Pult on 07.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "GameStatsController.h"

@implementation GameStatsController

static GameStatsController *defaultController = nil;

+ (GameStatsController *)defaultController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultController = [[GameStatsController alloc] init];
        NSDictionary *statsD = [defaultController readGameStatsFromPlist];
        [defaultController updatePropertiesWithDict:statsD];
        NSLog(@"Games Played: %i", defaultController.gamesPlayed);
    });
    return defaultController;
}

- (void)updatePropertiesWithDict:(NSDictionary *)dict
{
    self.currentLevel = [dict[@"Current Level"] intValue];
    self.gamesPlayed = [dict[@"Games Played"] intValue];
    self.loses = [dict[@"Loses"] intValue];
    self.wins = [dict[@"Wins"] intValue];
}

- (void)savePropertiesToPlist
{
    NSDictionary *statsD = [self dictionaryFromProperties];
    [self saveGameStatsToPlist:statsD];
}

- (NSDictionary *)dictionaryFromProperties
{
    NSDictionary *statsD = @{
                             @"Current Level" : @(self.currentLevel),
                             @"Games Played" : @(self.gamesPlayed),
                             @"Loses" : @(self.loses),
                             @"Wins" : @(self.wins)
                             };
    return statsD;
}

- (NSDictionary *)readGameStatsFromPlist;
{
    
    #warning Exercise 1-1 Load a NSDictionary from a plist
    
    // Code snippet: Read dictionary from a plist
    
    // Get path to user's Documents directory
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"gameStats.plist"];
    
    // On first launch get plist from main bundle
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"gameStats" ofType:@"plist"];
    }
    
    // Read dictionary from path
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // Check if reading from path was successful
    if (dict != nil) {
        NSLog(@"Read game stats from plist: %@", dict);
    } else {
        NSLog(@"Could not read plist at path %@", plistPath);
    }

// Code snippet END


    
    return dict;
    
}

- (BOOL)saveGameStatsToPlist:(NSDictionary *)dict;
{
    
    #warning Exercise 1-2 Save a NSDictionary to a plist
    
    // Code snippet: Saving a dicitonary to a plist
    
    // Get path to user's Documents directory
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"gameStats.plist"];
    
    // Write dictionary as plist to path
    BOOL success = [dict writeToFile:plistPath atomically:YES];
    
    // Check if saving to path was successful
    if(success) {
        NSLog(@"Saved game stats to plist: %@", dict);
        [[GameStatsController defaultController] updatePropertiesWithDict:dict];
        return YES;
    } else {
        NSLog(@"Could not save to plist at path %@", plistPath);
        return NO;
    }

    // Code snippet END
    
}

@end
