//
//  AppDelegate.m
//  IATodo
//
//  Created by Imre Mihaly on 9/6/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "IAServiceManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	MasterViewController *masterViewController = nil;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPhone" bundle:nil];
	    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	    self.window.rootViewController = self.navigationController;
	} else {
	    masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil];
	    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	    
	    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
	    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
		
		masterViewController.detailViewController = detailViewController;
		
	    self.splitViewController = [[UISplitViewController alloc] init];
	    self.splitViewController.delegate = detailViewController;
	    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
	    
	    self.window.rootViewController = self.splitViewController;
	}
	
	[[IAServiceManager sharedManager] registerService:masterViewController forSelector:@"todo://list"];
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	return [[IAServiceManager sharedManager] handleUrl:url];
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
