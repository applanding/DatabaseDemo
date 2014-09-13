//
//  BiographyDetailViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 22/08/12.
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
#import "BiographyViewController.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "ModelClass.h"

@interface BiographyDetailViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>{

    IBOutlet UIButton *backbt;
    IBOutlet UILabel *headerlable;
    IBOutlet UIWebView *biodetailwebview;
    IBOutlet UIButton *fbbtn;
    IBOutlet UIButton *mailbt;
    IBOutlet UIButton *tweetbt;
    NSString *biographytableselectedid;
    NSString *biodescription;
    


}
@property (retain, nonatomic) IBOutlet UIWebView *biodetailwebview;
@property (retain, nonatomic)  NSString *biographytableselectedid;
- (IBAction)fbsharing:(id)sender;
- (IBAction)sendmail:(id)sender;
- (IBAction)tweetshare:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)gotosms:(id)sender;

@end
