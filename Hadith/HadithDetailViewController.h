//
//  HadithDetailViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BMSocialShare/BMSocialShare.h>
#import "Quartzcore/quartzcore.h"
#import <Twitter/TWTweetComposeViewController.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "BiographyViewController.h"

@interface HadithDetailViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>{

    
    IBOutlet UIButton *backbt;
    IBOutlet UILabel *headerlable;
    IBOutlet UILabel *namelable;
    IBOutlet UILabel *detaillable;
    IBOutlet UILabel *fromlable;
    IBOutlet UIButton *fbsharebt;
    IBOutlet UIButton *msgbt;
    IBOutlet UIButton *tweetbtn;
    IBOutlet UILabel *hadithnum;
    IBOutlet UIButton *nextbtn;
    IBOutlet UIButton *backbtn;
    NSString *selectedhadithid;
    NSString *hadithdescription;
    NSString *hadithnumstring;
    NSString *selectedbooktitle;
    NSString *hadithtitle;
    IBOutlet UIButton *favbt;
    NSInteger i;
    NSMutableArray *hadithidforcounarray;
    NSString *isfavourite;
    NSString *tempbioid;
   
    
    
    
    
}
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *headerlable;
@property (retain, nonatomic) IBOutlet UILabel *namelable;
@property (retain, nonatomic) IBOutlet UILabel *detaillable;
@property (retain, nonatomic) IBOutlet UILabel *fromlable;
@property (retain, nonatomic) IBOutlet UIWebView *webview;
@property (retain, nonatomic) NSString *selectedhadithid;
@property (retain, nonatomic) IBOutlet UILabel *hadithnum;
@property (retain, nonatomic) NSString *hadithdescription;
@property (retain, nonatomic) NSString *hadithnumstring;
@property (retain, nonatomic) NSString *selectedbooktitle;
@property (retain, nonatomic) NSMutableArray *hadithidforcounarray;

@property (nonatomic,assign)NSInteger i; 

- (IBAction)gotosms:(id)sender;

- (IBAction)gotomsgs:(id)sender;
- (IBAction)setoffavourite:(id)sender;

- (IBAction)fbsharing:(id)sender;
- (IBAction)twittersharing:(id)sender;
- (IBAction)gonexthadith:(id)sender;
- (IBAction)gobackhadith:(id)sender;



@end
