//
//  SettingViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize view2;
@synthesize webview;
@synthesize settinglb,emailsenderaddress;
bool selfsend;
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
    settinglb.text = NSLocalizedString(@"set6",@"" );
    [[settingtable layer]setCornerRadius:10];
    [[settingtable layer]setBorderWidth:1.0];
    [settingbt addTarget:self.navigationController.parentViewController
               action:@selector(revealToggle:)
     forControlEvents:UIControlEventTouchUpInside];
    
   

    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    
    array = [[NSArray alloc]initWithObjects:NSLocalizedString(@"set1",@"" ),NSLocalizedString(@"set2",@"" ),NSLocalizedString(@"set3",@"" ),NSLocalizedString(@"set4",@"" ),nil];



}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{   
    //  NSLog(@"%d",[biographyidarray count]);
        return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // add a placeholder cell while waiting on table data
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    } 
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [settingtable deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) 
    {
        [Appirater setAppId:@"PUT_APP_ID"];
        [Appirater appLaunched:YES];
        [Appirater rateApp];
    }
    
    if (indexPath.row == 1) 
    {
        selfsend = NO;
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


    if (indexPath.row == 2) 
    {
        selfsend = YES;
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
    if (indexPath.row == 3) {
        NSString *urlAddress = @"http://www.alphabet-arabe-appli.com/hadith";
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webview loadRequest:requestObj];
        [self.view addSubview:view2];

    }
        
}



- (void)viewDidUnload
{
    
    [settingbt release];
    settingbt = nil;
    [self setSettinglb:nil];
    [self setView2:nil];
    [webview release];
    webview = nil;
    [self setWebview:nil];
    [cancelbutton release];
    cancelbutton = nil;
    [settingtable release];
    settingtable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc {
    [settingbt release];
    [settinglb release];
    [view2 release];
    [webview release];
    [webview release];
    [cancelbutton release];
    [settingtable release];
    [super dealloc];
}



-(void)displayComposerSheet 

{
   
        
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:[NSString stringWithFormat:@"Hadith App"]];
    
    // Set up recipients
     if (selfsend == NO){
    NSArray *toRecipients = [NSArray arrayWithObject:@""];
         [picker setToRecipients:toRecipients];
         NSString *emailBody = NSLocalizedString(@"set8", @"");
         [picker setMessageBody:emailBody isHTML:NO];
     }
     else {
        NSArray *toRecipients = [NSArray arrayWithObject:@"applicationalphaberarabe@gmail.com"];
         [picker setToRecipients:toRecipients];
         NSString *emailBody = NSLocalizedString(@"set7", @"");
         
         [picker setMessageBody:emailBody isHTML:YES];
     }
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", @"", nil]; 
    NSArray *bccRecipients = [NSArray arrayWithObject:@""]; 
    
    
    [picker setCcRecipients:ccRecipients];  
    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    /* NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
     NSData *myData = [NSData dataWithContentsOfFile:path];
     [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];*/
    
    // Fill out the email body text
    
    
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


- (IBAction)cancelwebpage:(id)sender {
    [view2 removeFromSuperview];
    
}

- (IBAction)goback:(id)sender {
    ViewController *back = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    
    //  [self.navigationController pushViewController:back animated:YES];
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:back atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];}

- (IBAction)getupdate:(id)sender {
    
        ViewController *rootview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil issyncing:YES];
        [self.navigationController pushViewController:rootview animated:NO];
    
}


@end
