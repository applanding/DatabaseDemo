//
//  AppDelegate.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BMSocialShare/BMSocialShare.h>
#import "Reachability.h"
#import "RevealController.h"

#import <sqlite3.h>
#import "HadithDetailViewController.h"
sqlite3 *database;

@class ViewController;
@class RevealController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigation;
    NSDictionary *apsInfo;
   

   
}
@property (strong, nonatomic) RevealController *viewController1;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@property(nonatomic,retain) NSString *databaseName;
@property(nonatomic,retain) NSString *databasePath;

-(void) createAndCheckDatabase;
-(BOOL)isHostAvailable;
-(BOOL)isNetAvalable;
@end
