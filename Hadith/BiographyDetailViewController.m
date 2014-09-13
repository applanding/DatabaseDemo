//
//  BiographyDetailViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 22/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "BiographyDetailViewController.h"

@interface BiographyDetailViewController ()

@end

@implementation BiographyDetailViewController
@synthesize biodetailwebview,biographytableselectedid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     headerlable.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
  
    FMDatabase *db=[[FMDatabase databaseWithPath:[Utility getDatabasePath]]autorelease];
    [db open]; 
   
    FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM biography_master where biography_id=%@",biographytableselectedid];
    
    while ([results next])
    {
        headerlable.text = [results stringForColumn:@"title"];
        biodescription = [[NSString alloc]initWithString:[results stringForColumn:@"description"]];
    }
    [results close];
    [db close];

    
    biodetailwebview = [biodetailwebview initWithFrame:CGRectMake(5, 60, 310, 350)];
    biodetailwebview.backgroundColor = [UIColor whiteColor];
    [[biodetailwebview layer] setCornerRadius:07];
    [biodetailwebview setClipsToBounds:YES];
    
    // Create colored border using CALayer property
    [[biodetailwebview layer] setBorderColor:
     [[UIColor colorWithRed:134.0/255.0 green:89.0/255.0 blue:35.0/255.0 alpha:1.0]CGColor]];
    [[biodetailwebview layer] setBorderWidth:1.00];
    [biodetailwebview loadHTMLString:biodescription baseURL:nil];
    [[self view] addSubview:biodetailwebview];
    [biodetailwebview release];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [backbt release];
    backbt = nil;
    [headerlable release];
    headerlable = nil;
    [biodetailwebview release];
    biodetailwebview = nil;
    [fbbtn release];
    fbbtn = nil;
    [mailbt release];
    mailbt = nil;
    [tweetbt release];
    tweetbt = nil;
    [self setBiodetailwebview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc {
    [backbt release];
    [headerlable release];
    [biodetailwebview release];
    [fbbtn release];
    [mailbt release];
    [tweetbt release];
    [biodetailwebview release];
    [super dealloc];
}
- (IBAction)fbsharing:(id)sender {
    
    NSString *title = [NSString stringWithFormat: @"%@ ",headerlable.text];
    NSString *myString = [NSString stringWithFormat: @"%@ Hadith Bukhari sur votre iPhone http://dfgljdj.fr",biodescription ];
    BMFacebookPost *post = [[BMFacebookPost alloc] initWithTitle:title descriptionText:myString andHref:@"http://www.google.com"];    
    
    [post setImageUrl:@"http://peerdevelopment.com/hadithapp/css/im/logo.jpg" withHref:@"http://www.google.com"];
    
    //  [post addPropertyWithTitle:@"Download" descriptionText:@"github.com/blockhaus/BMSocialShare" andHref:@"http://github.com/blockhaus/BMSocialShare"];
    
    // [post addPropertyWithTitle:@"Developed by" descriptionText:@"blockhaus" andHref:@"http://www.blockhaus-media.com"];
    
    [[BMSocialShare sharedInstance] facebookPublish:post];
    
}

- (IBAction)sendmail:(id)sender {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
    
     
}

-(void)displayComposerSheet 
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:[NSString stringWithFormat:@"Biography-%@",headerlable.text]];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@""]; 
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", @"", nil]; 
    NSArray *bccRecipients = [NSArray arrayWithObject:@""]; 
    
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];  
    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    /* NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
     NSData *myData = [NSData dataWithContentsOfFile:path];
     [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];*/
    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"<br/>%@ Hadith Bukhari sur votre iPhone http://dfgljdj.fr",biodescription];
    [picker setMessageBody:emailBody isHTML:YES];
    
    //  NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //  NSString *saveDirectory = [documentPath objectAtIndex:0];
    
    //  NSString *saveFileName = [NSString stringWithFormat:@"Receipt%@.pdf",[receiptidarray objectAtIndex:optionview.tag]];
    
    //  NSString *finalPath = [saveDirectory stringByAppendingPathComponent:saveFileName];
    
    //   NSData *pdfData = [NSData dataWithContentsOfFile:finalPath];
    // [picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:saveFileName];
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:?cc=,&subject=";
    
    //NSString *body = @"&bodIt is raining in sunny California!";
    NSString *body =[NSString stringWithFormat:@"&body=%@",[NSString stringWithFormat:@""]];
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


- (IBAction)tweetshare:(id)sender {
    
    if (NSClassFromString(@"TWTweetComposeViewController")) {
        // Initialize Tweet Compose View Controller
        TWTweetComposeViewController *vc = [[TWTweetComposeViewController alloc] init];
        
        // Settin The Initial Text
        
        NSString *myString = [NSString stringWithFormat: @"%@ \n %@ ",headerlable.text,biodescription];
        NSRange stringRange = {0, MIN([myString length], 100)}; 
        NSString *shortString = (stringRange.length <= [myString length]) ? myString : [myString substringWithRange:stringRange];
        
        if (stringRange.length > [myString length]){
             shortString = [NSString stringWithFormat:@"%@...Hadith Bukhari sur votre iPhone",myString];
            // throw exception, ignore error, or set shortString to myString
        }
        else {
            shortString = [NSString stringWithFormat:@"%@...Hadith Bukhari sur votre iPhone",[myString substringWithRange:stringRange]];
        }
        [vc setInitialText:shortString];
        
        // Adding an Image
        UIImage *image = [UIImage imageNamed:@""];
        [vc addImage:image];
        
        // Adding a URL
        NSURL *url = [NSURL URLWithString:@"http://dfgljdj.fr"];
        [vc addURL:url];
        
        // Setting a Completing Handler
        [vc setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            [self dismissModalViewControllerAnimated:YES];
        }];
        
        // Display Tweet Compose View Controller Modally
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }else {
        // Show Alert View When The Application Cannot Send Tweets
        NSString *message = @"The application cannot send a tweet at the moment. This is because it cannot reach Twitter or you don't have a Twitter account associated with this device.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }

}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gotosms:(id)sender {
     
    
    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        NSString *myString = [NSString stringWithFormat: @"%@ \n %@ ",headerlable.text,biodescription];
        NSRange stringRange = {0, MIN([myString length], 210)}; 
        NSString *shortString = (stringRange.length <= [myString length]) ? myString : [myString substringWithRange:stringRange];
        
        if (stringRange.length > [myString length]){
            shortString = [NSString stringWithFormat:@"%@...\n Hadith Bukhari sur votre iPhone http://dfgljdj.fr",myString];
            // throw exception, ignore error, or set shortString to myString
        }
        else {
            shortString = [NSString stringWithFormat:@"%@...\n Hadith Bukhari sur votre iPhone http://dfgljdj.fr",[myString substringWithRange:stringRange]];
        }
        
        controller.body = shortString;
        controller.recipients = [NSArray arrayWithObjects:@"", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
