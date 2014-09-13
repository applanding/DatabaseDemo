//
//  main.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSArray arrayWithObjects:@"fr", nil] forKey:@"AppleLanguages"];
        [defaults synchronize];

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
 
}
