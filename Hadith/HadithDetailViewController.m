//
//  HadithDetailViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "HadithDetailViewController.h"

@interface HadithDetailViewController ()

@end

@implementation HadithDetailViewController
@synthesize headerlable,i;
@synthesize namelable;
@synthesize detaillable;
@synthesize fromlable;
@synthesize webview;
@synthesize selectedhadithid;
@synthesize hadithnum,selectedbooktitle;
@synthesize hadithdescription,hadithnumstring,hadithidforcounarray;
int i;



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
    
  
    fromlable.font=[UIFont fontWithName:@"ArialMT" size:18];
    fromlable.text = NSLocalizedString(@"key10",@"" );
    
    namelable.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    detaillable.font=[UIFont fontWithName:@"ArialMT" size:15];
    headerlable.font = [UIFont fontWithName:@"ArialMT" size:20];
    hadithnum.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    headerlable.text = selectedbooktitle;
    
    FMDatabase *db= [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM hadith_master where hadith_id=%@",selectedhadithid];
    
    while ([results next])
        
    {
        hadithtitle =  [[NSString alloc]initWithString:[results stringForColumn:@"hadith_title"]];
        hadithnumstring = [results stringForColumn:@"hadith_num"];
        hadithdescription = [[NSString alloc]initWithString:[results stringForColumn:@"hadith"]];
        isfavourite = [[NSString alloc]initWithString:[results stringForColumn:@"hadith_fav"]];
    }
   
     
    if ([isfavourite isEqualToString:@"Y"]) {
        
        [favbt setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateNormal];
    }
    else {
        [favbt setBackgroundImage:[UIImage imageNamed:@"star-seven.png"] forState:UIControlStateNormal];
    }
    
    NSMutableArray *biographytitle = [[NSMutableArray alloc]init];
    NSMutableArray *biographydesc = [[NSMutableArray alloc] init];
    
    results =[db executeQueryWithFormat: @"select * from hadith_chain where hadith_id=%@",selectedhadithid];
    
    while ([results next]) 
    { 
        
        tempbioid= [[NSString alloc]initWithFormat:@"%@",[results stringForColumn:@"biography_id"]];
        
        FMResultSet *result =[db executeQueryWithFormat: @"select * from biography_master where biography_id=%@",tempbioid];
        while ([result next]) 
        {
            
            [biographytitle addObject:[result stringForColumn:@"title"]];
            [biographydesc addObject:[result stringForColumn:@"description"]];
            
            
        }
        
    } 
    if ([biographytitle count]!=0) {
        
        
        namelable.text = [biographytitle lastObject];
        detaillable.text = [biographydesc lastObject];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(29, 74, 150, 23);
    [button addTarget:self 
               action:@selector(buttonClicked:) 
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    webview = [webview initWithFrame:CGRectMake(5, 115, 310, 298)];
    webview.backgroundColor = [UIColor whiteColor];
    [[webview layer] setCornerRadius:07];
    [webview setClipsToBounds:YES];
    webview.opaque = YES;
    
    // Create colored border using CALayer property
    [[webview layer] setBorderColor:[[UIColor colorWithRed:134.0/255.0 green:89.0/255.0 blue:35.0/255.0 alpha:1.0]CGColor]];
    [[webview layer] setBorderWidth:1.00];
    
    hadithnum.text = hadithnumstring;
     NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *descriptionwithimage = [[NSString alloc]initWithFormat:@"%@",hadithdescription];
    descriptionwithimage = [descriptionwithimage stringByReplacingOccurrencesOfString:@"{#img#}" withString:@" <img src=\"hadith.png\"> "];
  
    [webview loadHTMLString:descriptionwithimage baseURL:baseURL];
    
    [[self view] addSubview:webview];
    
    // Do any additional setup after loading the view from its nib.
    if ([hadithidforcounarray count]==1 || [hadithidforcounarray count]==0 ) {
        nextbtn.enabled = NO;
        backbtn.enabled = NO;
        
    }
    

   
   }

-(void)buttonClicked:(id)sender{
    
    BiographyDetailViewController *biodetailview =[[BiographyDetailViewController alloc]initWithNibName:@"BiographyDetailViewController" bundle:nil];
    
    biodetailview.biographytableselectedid = [[NSString alloc]initWithString:tempbioid];
    [self.navigationController pushViewController:biodetailview animated:YES];



}


- (IBAction)gonexthadith:(id)sender {
    
  
    if (i!=[hadithidforcounarray count]-1) 
    {
        backbtn.userInteractionEnabled=YES;
        backbtn.enabled = YES;
        if (i==[hadithidforcounarray count]-2) {
            nextbtn.userInteractionEnabled = NO;
            nextbtn.enabled = NO;
        }
        
       
        i++;
        selectedhadithid = [hadithidforcounarray objectAtIndex:i];
       
       
        FMDatabase *db= [FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM hadith_master where hadith_id=%@",selectedhadithid];
        
        while ([results next])
            
        {
            hadithtitle =  [[NSString alloc]initWithString:[results stringForColumn:@"hadith_title"]];
            hadithnumstring = [results stringForColumn:@"hadith_num"];
            hadithdescription = [[NSString alloc]initWithString:[results stringForColumn:@"hadith"]];
            isfavourite = [[NSString alloc]initWithString:[results stringForColumn:@"hadith_fav"]];
        }
       
        if ([isfavourite isEqualToString:@"Y"]) {
            
            [favbt setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateNormal];
        }
        else {
            [favbt setBackgroundImage:[UIImage imageNamed:@"star-seven.png"] forState:UIControlStateNormal];
        }

        
       
        NSMutableArray *biographytitle = [[NSMutableArray alloc]init];
        NSMutableArray *biographydesc = [[NSMutableArray alloc] init];
        results =[db executeQueryWithFormat: @"select * from hadith_chain where hadith_id=%@",selectedhadithid];
        
        while ([results next]) 
        { 
            
          tempbioid= [[NSString alloc]initWithFormat:@"%@",[results stringForColumn:@"biography_id"]];
            
            
            FMResultSet *result =[db executeQueryWithFormat: @"select * from biography_master where biography_id=%@",tempbioid];
            while ([result next]) 
            {
                
                [biographytitle addObject:[result stringForColumn:@"title"]];
                [biographydesc addObject:[result stringForColumn:@"description"]];
                
                
            }
            
        } 
        if ([biographytitle count]!=0) 
        {
            
            namelable.text = [biographytitle lastObject];
            detaillable.text = [biographydesc lastObject];
        }
    
        hadithnum.text = hadithnumstring;
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *descriptionwithimage = [[NSString alloc]initWithFormat:@"%@",hadithdescription];
        descriptionwithimage = [descriptionwithimage stringByReplacingOccurrencesOfString:@"{#img#}" withString:@" <img src=\"hadith.png\"> "];
        [webview loadHTMLString:descriptionwithimage baseURL:baseURL];


    }
    else {
        nextbtn.userInteractionEnabled = NO;
        nextbtn.enabled=NO;
    }

    
}

- (IBAction)gobackhadith:(id)sender {
     
    if (i!=0) {
        nextbtn.userInteractionEnabled = YES;
        nextbtn.enabled = YES;
        if (i==1) {
            backbtn.userInteractionEnabled=NO;
            backbtn.enabled = NO;
        }
        
      
        i--;
        selectedhadithid = [hadithidforcounarray objectAtIndex:i];
      
        FMDatabase *db= [FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM hadith_master where hadith_id=%@",selectedhadithid];
        
        while ([results next])
            
        {
            hadithnumstring = [results stringForColumn:@"hadith_num"];
            hadithdescription = [[NSString alloc]initWithString:[results stringForColumn:@"hadith"]];
            hadithtitle = [[NSString alloc]initWithString:[results stringForColumn:@"hadith_title"]];
            isfavourite = [[NSString alloc]initWithString:[results stringForColumn:@"hadith_fav"]];
        }
       
        if ([isfavourite isEqualToString:@"Y"]) {
            
            [favbt setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateNormal];
        }
        else {
            [favbt setBackgroundImage:[UIImage imageNamed:@"star-seven.png"] forState:UIControlStateNormal];
        }

       
        NSMutableArray *biographytitle = [[NSMutableArray alloc]init];
        NSMutableArray *biographydesc = [[NSMutableArray alloc] init];
        results =[db executeQueryWithFormat: @"select * from hadith_chain where hadith_id=%@",selectedhadithid];
        
        while ([results next]) 
        { 
            
           tempbioid= [[NSString alloc]initWithFormat:@"%@",[results stringForColumn:@"biography_id"]];
            
            
            FMResultSet *result =[db executeQueryWithFormat: @"select * from biography_master where biography_id=%@",tempbioid];
            while ([result next]) 
            {
                
                [biographytitle addObject:[result stringForColumn:@"title"]];
                [biographydesc addObject:[result stringForColumn:@"description"]];
                
                
            }
            
        } 
        if ([biographytitle count]!=0) {
            
            namelable.text = [biographytitle lastObject];
            detaillable.text = [biographydesc lastObject];
        }
        hadithnum.text = hadithnumstring;
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *descriptionwithimage = [[NSString alloc]initWithFormat:@"%@",hadithdescription];
        descriptionwithimage = [descriptionwithimage stringByReplacingOccurrencesOfString:@"{#img#}" withString:@" <img src=\"hadith.png\"> "];
        [webview loadHTMLString:descriptionwithimage baseURL:baseURL];

    }
    else {
        backbtn.userInteractionEnabled = NO;
        backbtn.enabled = NO;
    }
   
}


- (IBAction)setoffavourite:(id)sender {
   
   
    FMDatabase *db= [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    if ([isfavourite isEqualToString:@"N"]) 
    {
        
    
    BOOL success = [db executeUpdateWithFormat:@"UPDATE hadith_master SET hadith_fav=%@ where hadith_id=%@",@"Y",selectedhadithid]; ;
    
    if (!success)
    {
        NSLog(@"update failed hadith fav!!");
    }
        else 
        {
        
        NSLog(@"successfully updated hadith fav");
        [favbt setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateNormal];
        isfavourite =@"Y"; 
   
        }
    NSLog(@"update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    
    }
    else 
    {
        
        BOOL success1 = [db executeUpdateWithFormat:@"UPDATE hadith_master SET hadith_fav=%@ where hadith_id=%@",@"N",selectedhadithid]; ;
        
        if (!success1)
        {
            NSLog(@"update failed hadith fav!!");
        }
        else 
        {
            
            [favbt setBackgroundImage:[UIImage imageNamed:@"star-seven.png"] forState:UIControlStateNormal];
            NSLog(@"successfully updated hadith fav");
            isfavourite=@"N";
            
            
        }
        NSLog(@"update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        
    }
     
    
}



- (void)viewDidUnload
{
    [backbt release];
    backbt = nil;
    [headerlable release];
    headerlable = nil;
    [self setHeaderlable:nil];
    [self setNamelable:nil];
    [self setDetaillable:nil];
    [self setFromlable:nil];
    [self setWebview:nil];
    [fbsharebt release];
    fbsharebt = nil;
    [msgbt release];
    msgbt = nil;
    [tweetbtn release];
    tweetbtn = nil;
    [hadithnum release];
    hadithnum = nil;
    [self setHadithnum:nil];
    [nextbtn release];
    nextbtn = nil;
    [backbtn release];
    backbtn = nil;
    [favbt release];
    favbt = nil;
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
    [headerlable release];
    [namelable release];
    [detaillable release];
    [fromlable release];
    [webview release];
    [fbsharebt release];
    [msgbt release];
    [tweetbtn release];
    [hadithnum release];
    [hadithnum release];
    [nextbtn release];
    [backbtn release];
    [favbt release];
    [super dealloc];
}
- (IBAction)goback:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)gotosms:(id)sender {
    

    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        NSString *myString = [NSString stringWithFormat: @"%@ Hadith %@ \n rapporté par %@ \n %@",headerlable.text, hadithnum.text,namelable.text,hadithtitle];
        
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


- (IBAction)gotomsgs:(id)sender {
   
    
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
    
    [picker setSubject:[NSString stringWithFormat:@"Hadith %@",hadithnum.text]];
    
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
     NSString *myString = [NSString stringWithFormat: @"%@ Hadith %@ <br/> rapporté par %@ <br/> %@",headerlable.text, hadithnum.text,namelable.text,hadithtitle];
    NSString *emailBody = [NSString stringWithFormat:@"%@ <br/> Hadith Bukhari sur votre iPhone http://dfgljdj.fr",myString];
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


- (IBAction)fbsharing:(id)sender {
   
    NSString *title = [NSString stringWithFormat: @"%@ Hadith %@ \n Rapporté par %@",headerlable.text, hadithnum.text,namelable.text];
     NSString *myString = [NSString stringWithFormat: @"%@.. Hadith Bukhari sur votre iPhone http://dfgljdj.fr",hadithtitle];
    BMFacebookPost *post = [[BMFacebookPost alloc] initWithTitle:title descriptionText:myString andHref:@"http://dfgljdj.fr"];    
    
    [post setImageUrl:@"http://peerdevelopment.com/hadithapp/css/im/logo.jpg" withHref:@"http://www.google.com"];
    
  //  [post addPropertyWithTitle:@"Download" descriptionText:@"github.com/blockhaus/BMSocialShare" andHref:@"http://github.com/blockhaus/BMSocialShare"];
    
   // [post addPropertyWithTitle:@"Developed by" descriptionText:@"blockhaus" andHref:@"http://www.blockhaus-media.com"];
    
    [[BMSocialShare sharedInstance] facebookPublish:post];
    
}

- (IBAction)twittersharing:(id)sender {
 
    
    if (NSClassFromString(@"TWTweetComposeViewController")) {
        // Initialize Tweet Compose View Controller
        TWTweetComposeViewController *vc = [[TWTweetComposeViewController alloc] init];
        
        // Settin The Initial Text
       
       NSString *myString = [NSString stringWithFormat: @"%@",hadithtitle];
        NSRange stringRange = {0, MIN([myString length], 80)}; 
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
    
  //  [[BMSocialShare sharedInstance] twitterPublishText:@"Posting to Facebook, Twitter and Email made dead simple on iOS with BMSocialShare" withImage:nil
      //                                          andURL:[NSURL URLWithString:@"http://github.com/blockhaus/BMSocialShare"]
        //                        inParentViewController:self]; 

    
    }


    
@end
