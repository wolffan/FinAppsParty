//
//  AppDelegate.m
//  FinAppsParty
//
//  Created by Valenti on 26/10/12.
//  Copyright (c) 2012 Valenti. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "HistoricPageViewController.h"
#import "ProfilePageViewController.h"
#import "ReadData.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize tabBarController;

- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            // Perform additional tasks for the authenticated player.
        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"arrayComerceUnlocked"]){
        NSData *myEncodedObjectDiv = [defaults objectForKey:@"arrayComerceUnlocked"];
        [[ReadData instance] setArrayComerceUnlocked:(NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObjectDiv]];
    }
    if([defaults objectForKey:@"score"]){
        NSInteger recordScore =[defaults integerForKey:@"score"];
        [ReadData instance].score = recordScore;
    }
    
    [self authenticateLocalPlayer];

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];

    UINavigationController *myNavigationController;
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    
    //1
    HistoricPageViewController *vc1 = [[HistoricPageViewController alloc] initWithNibName:@"HistoricPageViewController" bundle:nil];
    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@" " image:[UIImage imageNamed:@"tabBarUnloock.png"] tag:1];
    [vc1 setTabBarItem:tab1];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    [tabs addObject:myNavigationController];
    [tab1 release];
    [vc1 release];
    [myNavigationController release];
    
    //2
    MainPageViewController *vc2 = [[MainPageViewController alloc] initWithNibName:@"MainPageViewController" bundle:nil];
    UITabBarItem *tab2 = [[UITabBarItem alloc] initWithTitle:@" " image:[UIImage imageNamed:@"tabBarExplor.png"] tag:2];
    [vc2 setTabBarItem:tab2];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    [tabs addObject:myNavigationController];
    [tab2 release];
    [vc2 release];
    [myNavigationController release];

    //3
    ProfilePageViewController *vc3 = [[ProfilePageViewController alloc] initWithNibName:@"ProfilePageViewController" bundle:nil];
    UITabBarItem *tab3 = [[UITabBarItem alloc] initWithTitle:@" " image:[UIImage imageNamed:@"tabBarProfile.png"] tag:3];
    [vc3 setTabBarItem:tab3];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    [tabs addObject:myNavigationController];
    [tab3 release];
    [vc3 release];
    [myNavigationController release];

    [self.tabBarController setViewControllers:tabs];
    [self.tabBarController setSelectedIndex:1];
    [tabs release];
    
    // Get the Layer of any view
//    CALayer *l = [self.window layer];
//    [l setMasksToBounds:YES];
//    [l setCornerRadius:10.0];
//    
//    // You can even add a border
//    [l setBorderWidth:.75];
//    [l setBorderColor:[[UIColor greenColor] CGColor]];
    
    [self customizeInterface];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) customizeInterface{
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabBar.png"];
    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITabBar appearance] setTintColor:[UIColor clearColor]];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabBarSelect.png"]];
    
    // Set tint color for the images only for this tabbar
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *myEncodedObjectDiv = [NSKeyedArchiver archivedDataWithRootObject:[[ReadData instance] arrayComerceUnlocked]];
	[defaults setObject:myEncodedObjectDiv forKey:@"arrayComerceUnlocked"];

    NSInteger recordScore = [ReadData instance].score;
    [defaults setInteger:recordScore forKey:@"score"];
    [defaults synchronize];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FinAppsParty" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FinAppsParty.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
