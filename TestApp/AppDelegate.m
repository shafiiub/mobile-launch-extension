/*
 ADOBE CONFIDENTIAL
 
 Copyright 2019 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it. If you have received this file from a source other than Adobe,
 then your use, modification, or distribution of it requires the prior
 written permission of Adobe.
 */

#import "AppDelegate.h"
#import "WeatherExtension.h"
#import "ACPCore.h"
#import "ACPIdentity.h"
#import "ACPSignal.h"
#import "ACPLifecycle.h"
#import "ACPAnalytics.h"

// fill in your API key here
//static NSString *const ACPWeatherExampleApiKey = @"9fd42e373a60120335706c235286c3d1";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ACPCore setLogLevel:ACPMobileLogLevelDebug];
    //[ACPCore configureWithAppId:@"staging/launch-ENb44c5c8eb4ac4c5b8c89b6afffc167f7-development"];
    [ACPCore configureWithAppId:@"22d52f3c11b2/f367ac17c1da/launch-a905aa558861-development"];
    
    // register the weather extension
    [WeatherExtension registerExtension];
    
    // register Adobe core extensions
    [ACPIdentity registerExtension];
    [ACPSignal registerExtension];
    [ACPLifecycle registerExtension];
    [ACPAnalytics registerExtension];
    
    // after registering all the extensions, call ACPCore start to start procesing events in the Event Hub
    [ACPCore start:^{
        //[ACPCore updateConfiguration:@{@"weather.apiKey":ACPWeatherExampleApiKey}];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateBackground) {
                [ACPCore lifecycleStart:nil];
            }
        });
    }];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [ACPCore lifecyclePause];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [ACPCore lifecycleStart:nil];
}

@end
