//
//  AppDelegate.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize databaseName,databasePath;
@synthesize viewController1;
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    self.databaseName = @"hadith_db.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    [self createAndCheckDatabase];
       
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK)
	{
		sqlite3_close(database);
		NSLog(@"Failed to open db.");
	}
	else{
		NSLog(@"Open DB");
    }
    

    if (launchOptions != nil)
	{
		NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (userInfo != nil)
		{
            self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
            ViewController *rearViewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            navigation =[[UINavigationController alloc]initWithRootViewController:self.viewController];
            navigation.navigationBar.hidden=YES;
            RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigation rearViewController:rearViewController];
            self.viewController1 = revealController;
            self.window.rootViewController = self.viewController1;
            [self.window makeKeyAndVisible];
            
           apsInfo = [[NSDictionary alloc]initWithDictionary:[userInfo objectForKey:@"aps"]];
            
            
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            
            FMResultSet *forcount = [db executeQuery:[NSString stringWithFormat:@"SELECT count(hadith_id) from hadith_master where hadith_id=%@",[[userInfo objectForKey:@"aps"]objectForKey:@"i"]]];
            
            while([forcount next]) 
            {
                
               
                if ([forcount intForColumn:@"count(hadith_id)"]>0 ) 
                {
                    
                    HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
                    gotohadithdetail.selectedbooktitle = [[userInfo objectForKey:@"aps"]objectForKey:@"t"];
                    gotohadithdetail.selectedhadithid =[[userInfo objectForKey:@"aps"]objectForKey:@"i"];
                      [navigation pushViewController:gotohadithdetail animated:YES]; 

                                       
                }
                else if ([forcount intForColumn:@"count(hadith_id)"]==0){
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"SYNC" message:[NSString stringWithFormat:@"Please do synchronization to view %@",[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"SYNC" otherButtonTitles:@"CANCEL", nil];
                    [alert show];
                    [alert release];
                    
                }

            }   
	}
    }   
    else {

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
  //  HadithsViewController *frontViewController = [[HadithsViewController alloc] initWithNibName:@"HadithsViewController" bundle:nil];
	ViewController *rearViewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    navigation =[[UINavigationController alloc]initWithRootViewController:self.viewController];
    navigation.navigationBar.hidden=YES;
    RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigation rearViewController:rearViewController];
	self.viewController1 = revealController;
	self.window.rootViewController = self.viewController1;
    [self.window makeKeyAndVisible];
    }
    
       

	
    
    return YES;

}

-(void) createAndCheckDatabase
{
    BOOL success; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];

    if(success) return; 
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}
- (NSString *)dataFilePath
{
	BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success)
    {
        return databasePath;
        
    }else {
        return NO;
    }
}


-(BOOL)isHostAvailable
{
    Reachability *hostReachable = [Reachability reachabilityWithHostName: @"www.google.com"];
    BOOL isHostAvailable;
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            isHostAvailable = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            isHostAvailable = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            isHostAvailable = YES;
            
            break;
        }
    }
    return isHostAvailable;
    
}

-(BOOL)isNetAvalable
{
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    BOOL isNetAvalable;
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            isNetAvalable = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            isNetAvalable = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            isNetAvalable = YES;
            break;
        }
    }
    return isNetAvalable;
    
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken { 
    
    
    
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    // Check what Notifications the user has turned on. We registered for all three, but they may have manually disabled some or all of them.
    NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    
    // Set the defaults to disabled unless we find otherwise...
    NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
    NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
    NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
    
    // Get the users Device Model, Display Name, Unique ID, Token & Version Number
    UIDevice *dev = [UIDevice currentDevice];
    NSString *deviceUuid;
    if ([dev respondsToSelector:@selector(uniqueIdentifier)])
        deviceUuid = dev.uniqueIdentifier;
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id uuid = [defaults objectForKey:@"deviceUuid"];
        if (uuid)
            deviceUuid = (NSString *)uuid;
        else {
            CFStringRef cfUuid = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
            deviceUuid = (NSString *)cfUuid;
            CFRelease(cfUuid);
            [defaults setObject:deviceUuid forKey:@"deviceUuid"];
        }
    }
    NSString *deviceName = dev.name;
    NSString *deviceModel = dev.model;
    NSString *deviceSystemVersion = dev.systemVersion;
    
    // Prepare the Device Token for Registration (remove spaces and < >)
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    // Build URL String for Registration
    // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
    // !!! SAMPLE: "secure.awesomeapp.com"
    NSString *host = @"192.168.1.100/hadithapp";
    
    
    // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED
    // !!! ( MUST START WITH / AND END WITH ? ).
    // !!! SAMPLE: "/path/to/apns.php?"
    NSString *urlString = [NSString stringWithFormat:@"/protected/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
    
    // Register the Device Data
    // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
    NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
      NSLog(@"Return Data: %@", returnData);
    
    
    
    //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Devicetoken" message:tokenstring delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //   [alert show];
    //   [alert release];
    
}



- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@",str);    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
   
    apsInfo = [[NSDictionary alloc]initWithDictionary:[userInfo objectForKey:@"aps"]];
   // apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSLog(@"Received Push Alert: %@", alert);
    
    NSString *sound = [apsInfo objectForKey:@"sound"];
    NSLog(@"Received Push Sound: %@", sound);
    
    
    NSString *badge = [apsInfo objectForKey:@"badge"];
    NSLog(@"Received Push Badge: %@", badge);
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;    
    
    
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *forcount = [db executeQuery:[NSString stringWithFormat:@"SELECT count(hadith_id) from hadith_master where hadith_id=%@",[apsInfo objectForKey:@"i"]]];
        
        while([forcount next]) 
        {
            
           
            if ([forcount intForColumn:@"count(hadith_id)"]>0 ) 
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Push Notification" message:[NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"VIEW" otherButtonTitles:@"CANCEL", nil];
                [alert show];
                [alert release];

            }
            else if ([forcount intForColumn:@"count(hadith_id)"]==0){
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"SYNC" message:[NSString stringWithFormat:@"Please do synchronization to view %@",[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"SYNC" otherButtonTitles:@"CANCEL", nil];
                [alert show];
                [alert release];

        }
        }
              
    }
    else if (state == UIApplicationStateInactive) {
       
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        ViewController *rearViewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        navigation =[[UINavigationController alloc]initWithRootViewController:self.viewController];
        navigation.navigationBar.hidden=YES;
        RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigation rearViewController:rearViewController];
        self.viewController1 = revealController;
        self.window.rootViewController = self.viewController1;
        [self.window makeKeyAndVisible];

        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *forcount = [db executeQuery:[NSString stringWithFormat:@"SELECT count(hadith_id) from hadith_master where hadith_id=%@",[apsInfo objectForKey:@"i"]]];
        
        while([forcount next]) 
        {
            
           
            if ([forcount intForColumn:@"count(hadith_id)"]>0 ) 
            {
                HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
                gotohadithdetail.selectedbooktitle = [apsInfo objectForKey:@"t"];
                gotohadithdetail.selectedhadithid =[apsInfo objectForKey:@"i"];
                [navigation pushViewController:gotohadithdetail animated:YES];                  
            }
            else if ([forcount intForColumn:@"count(hadith_id)"]==0){
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"SYNC" message:[NSString stringWithFormat:@"Please do synchronization to view %@",[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"SYNC" otherButtonTitles:@"CANCEL", nil];
                [alert show];
                [alert release];
                
            }
        }

        
                             
    }	
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
   
    if ([alertView.title isEqualToString:@"Push Notification"]) {
        if (buttonIndex == 0)
        {
            
            self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
            ViewController *rearViewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            navigation =[[UINavigationController alloc]initWithRootViewController:self.viewController];
            navigation.navigationBar.hidden=YES;
            RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigation rearViewController:rearViewController];
            self.viewController1 = revealController;
            self.window.rootViewController = self.viewController1;
            [self.window makeKeyAndVisible];

            HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
            gotohadithdetail.selectedbooktitle = [apsInfo objectForKey:@"t"];
            gotohadithdetail.selectedhadithid =[apsInfo objectForKey:@"i"];
            [navigation pushViewController:gotohadithdetail animated:YES];        
        }

        
    }
    if ([alertView.title isEqualToString:@"SYNC"]) {
        ViewController *gotoview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil string:YES];
        gotoview.pushtitle = [[NSString alloc]initWithString:[apsInfo objectForKey:@"t"]];
        gotoview.pushhid = [[NSString alloc]initWithString:[apsInfo objectForKey:@"i"]];

        [navigation pushViewController:gotoview animated:NO];
        
    }
        
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // include this for Single Sign On (SSO) to work
    // https://developers.facebook.com/docs/mobile/ios/build/#implementsso
    return [[BMSocialShare sharedInstance] facebookHandleOpenURL:url];
}


// for iOS > 4.2 make sure you use
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[BMSocialShare sharedInstance] facebookHandleOpenURL:url];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     THIS CALL IS ESSENTIAL TO KEEP ACCESS TO FACEBOOK!
     MAKE SURE YOU IMPLEMENT IT IN YOUR OWN APP! ;)
     */
    [[BMSocialShare sharedInstance] facebookExtendAccessToken];
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



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
