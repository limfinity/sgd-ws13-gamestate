//
//  GameStatsController.h
//  Fat.Finger
//
//  Description:
//  Class to handle all the game stats.
//
//  Created by Peter Pult on 07.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

@interface GameStatsController : NSObject

@property (nonatomic, assign) int currentLevel;
@property (nonatomic, assign) int gamesPlayed;
@property (nonatomic, assign) int loses;
@property (nonatomic, assign) int wins;

+ (GameStatsController *)defaultController;
- (void)updatePropertiesWithDict:(NSDictionary *)dict;
- (void)savePropertiesToPlist;
- (NSDictionary *)dictionaryFromProperties;

/*! Get a NSDictionary from the current version of the given plist.
 * \returns A dicitionary with content of plist
 */
- (NSDictionary *)readGameStatsFromPlist;

/*! Saves new game stats into a plist. Note that it always replaces all the information in the given plist instead of adding information.
 * \param dict An dictionary with all the new game stats, make sure to use the right keys
 * \returns A bool which states if the new data was successfully saved
 */
- (BOOL)saveGameStatsToPlist:(NSDictionary *)dict;

@end
