//
//  AppDelegate.m
//  orderv2
//
//  Created by Kumari, Reena on 6/3/19.
//  Copyright © 2019 Kumari, Reena. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
   
    NSDictionary *queryParams = [self parseQueryString:[url query]];
    NSLog(@"query queryParams: %@", queryParams);
    ViewController *viewController = [self getViewControllerInstance];
    
    if([[url host] isEqual:@"success"]){
        NSLog(@"success");
        [viewController success: queryParams[@"token"]];
        return YES;
    }
    if([[url host] isEqual:@"cancel"]){
        NSLog(@"cancel");
        [viewController cancel: queryParams[@"token"]];
        return YES;
    }
    if([[url host] isEqual:@"error"]){
        NSLog(@"error");
        [viewController error: queryParams[@"token"]];
        return YES;
    }
    return NO;
    
}
- (ViewController *) getViewControllerInstance {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    ViewController *controller = (ViewController*)[mainStoryboard
                                                   instantiateViewControllerWithIdentifier: @"mainView"];
    //self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return controller;
}


- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        [dictionary setObject:[elements objectAtIndex:1] forKey:[elements objectAtIndex:0]];
    }
    return dictionary;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
