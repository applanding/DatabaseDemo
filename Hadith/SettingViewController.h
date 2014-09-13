//
//  SettingViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/Quartzcore.h"
#import "ViewController.h"
#import "Appirater.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingViewController : UIViewController<MFMailComposeViewControllerDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    
    
    IBOutlet UIButton *settingbt;
    NSString *emailsenderaddress;
    IBOutlet UIWebView *webview;
    IBOutlet UIButton *cancelbutton;
    IBOutlet UITableView *settingtable;
    NSArray *array;
}


@property (retain, nonatomic) IBOutlet UILabel *settinglb;
@property (retain, nonatomic)  NSString *emailsenderaddress;
@property (retain, nonatomic) IBOutlet UIView *view2;
@property (retain, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)cancelwebpage:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)getupdate:(id)sender;


@end
