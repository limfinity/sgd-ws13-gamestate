//
//  AppDelegate.m
//  Fat.Finger
//
//  Description:
//  Class to handle all basic functions to keep the app running.
//
//  Created by Peter Pult on 06.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

/*! Handles a change in the iCloud storage. Compares new data with local data and decides which data is the winner.
 * \param notification Notification which carries the object on which the change was called
 */
-(void)storeDidChange:(NSNotification *)notification;

@end

@implementation AppDelegate

-(void)storeDidChange:(NSNotification *)notification
{
    GameStatsController *statsController = [GameStatsController defaultController];

    // Get the dictionary from the local iCloud key-value store.
    NSDictionary *cloudStatsD = [[NSUbiquitousKeyValueStore defaultStore] dictionaryForKey:@"GAME_STATS"];

    NSLog(@"GameStats from cloud: %@", cloudStatsD);

    // Get the total of games played from iCloud.
    int gamesPlayedCloud = [cloudStatsD[@"Games Played"] intValue];

    // Compare iCloud games played with local games played.
    if (gamesPlayedCloud > [statsController gamesPlayed]) {
        
        // Save new stats from iCloud to local plist
        if ([statsController saveGameStatsToPlist:cloudStatsD]) {
            NSLog(@"Updated new game stats from cloud.");
        } else {
            NSLog(@"Error updating new game stats from cloud.");
        }
    } else {
        NSLog(@"More games played (%i) locally than number of games played (%i) pushed from iCloud", [statsController gamesPlayed], gamesPlayedCloud);
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Call the defaultController so it is allready instanciated
    [GameStatsController defaultController];
    
    
    
    #warning Exercise 2-1 Get new data from iCloud
    
    // Code snippet: Check for iCloud access
    
    id token = [[NSFileManager defaultManager] ubiquityIdentityToken];
    if (token) {
        NSLog(@"iCloud access");
    } else {
        NSLog(@"No iCloud access.");
    }
    
    // Code snippet END
    
    // Get the shared local iCloud key-value store object, it knows which data to get and set because it is tied to the unique identifier set in the apps entitlements.
    NSUbiquitousKeyValueStore *kvStore = [NSUbiquitousKeyValueStore defaultStore];
    
    // Add a observer to the app, to get notified when changes are made to the local key-value store.
    // NOTE: Not the app is connected to iCloud but the local key-value store, which works as an agent between iCloud and the app.
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(storeDidChange:)
                                                 name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object: kvStore];
    
    // Get changes made while this instance of the app wasn't running.
    [kvStore synchronize];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // Save the current game stats to a plist, so they don't get lost
    [[GameStatsController defaultController] savePropertiesToPlist];
    
    
    
    #warning Exercise 2-2 Save new data to iCloud
    
    // Get the shared local iCloud key-value store object.
    NSUbiquitousKeyValueStore *kvStore = [NSUbiquitousKeyValueStore defaultStore];

    // Get new values to store in the local iCloud key-value store.
    NSDictionary *statsD = [[GameStatsController defaultController] dictionaryFromProperties];

    NSLog(@"GameStats to cloud: %@", statsD);

    // Store new values to local iCloud key-value store.
    [kvStore setDictionary:statsD forKey:@"GAME_STATS"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
