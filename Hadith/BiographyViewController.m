//
//  BiographyViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "BiographyViewController.h"

@interface BiographyViewController ()

@end

@implementation BiographyViewController
@synthesize headerlable;
@synthesize biographylistingtable;

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
    headerlable.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    headerlable.text =  NSLocalizedString(@"key8",@"" );
    biographyidarray = [[NSMutableArray alloc]init];
    titlearray  = [[NSMutableArray alloc]init];
    descriptionarray = [[NSMutableArray alloc]init];

  //  NSString *time1;
    
      
   //
    
    // Get
    
   /* 
    NSLog(@"time%@",time1);
    
    NSTimeInterval _interval=[time1 doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
    NSString *datestring=[_formatter stringFromDate:date];
    NSLog(@"dateconverted %@",datestring);
    NSTimeInterval ti = [[NSDate date]timeIntervalSince1970];
    NSLog(@"%.0f",ti);

    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:ti];
    NSDateFormatter *_formatter2=[[NSDateFormatter alloc]init];
    [_formatter2 setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
    NSString *datestring2=[_formatter stringFromDate:date2];
    NSLog(@"dateconverted %@",datestring2);
*/

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
   
   
    FMDatabase *db=[[FMDatabase databaseWithPath:[Utility getDatabasePath]]autorelease];
    [db open]; 
  
    FMResultSet *forcount = [db executeQueryWithFormat:@"SELECT count(biography_id) from biography_master"];
    
       
    while([forcount next]) 
    {
        
       
        if ([forcount intForColumn:@"count(biography_id)"]>0 ) {
    
    NSString *activeyes= @"Y";
    NSString *deleteno = @"N";
    FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM biography_master where is_active=%@ and is_deleted=%@",activeyes,deleteno];
    
    while ([results next])
    {
        
        [biographyidarray addObject:[results stringForColumn:@"biography_id"]];
        [titlearray addObject:[results stringForColumn:@"title"]];
        [descriptionarray addObject:[results stringForColumn:@"description"]];
       
    }
    
    [results close];
            
        }
    }
    [db close];

    
}

   

- (void)viewDidUnload
{
    [backbtn release];
    backbtn = nil;
    [headerlable release];
    headerlable = nil;
    [self setHeaderlable:nil];
    [biographylistingtable release];
    biographylistingtable = nil;
    [self setBiographylistingtable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{   
 
    if ([biographyidarray count]==0) {
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"" message:@"No Biography Found" delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];  
        [alert1 show];
        [alert1 release];
    }

    return [biographyidarray count];
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
    
   UIView *uview=[[UIView alloc]initWithFrame:CGRectMake(7,3,303,48)];
    uview.layer.masksToBounds=YES;
    UIImageView *cellbackground =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,303,48)]; 
    cellbackground.image=[[UIImage alloc]init];
    cellbackground.image = [UIImage imageNamed:@"04.png"];
    UIImageView *cellarrow =[[UIImageView alloc] initWithFrame:CGRectMake(280,14,13,20)]; 
    cellarrow.image=[[UIImage alloc]init];
    cellarrow.image = [UIImage imageNamed:@"06.png"];

    UILabel *mainlb = [[UILabel alloc]initWithFrame:CGRectMake(12,1,270,29)];
    [mainlb setTextColor:[UIColor colorWithRed:187.0/255.0 green:44.0/255.0 blue:61.0/255.0 alpha:1.0]];
    [mainlb setBackgroundColor:[UIColor clearColor]];
    mainlb.textAlignment = UITextAlignmentLeft;
    mainlb.font=[UIFont fontWithName:@"Arial-BoldMT" size:18];
    mainlb.text = [titlearray objectAtIndex:indexPath.row];
    
    UILabel *detaillb = [[UILabel alloc]initWithFrame:CGRectMake(12,20,240,25)];
    [detaillb setTextColor:[UIColor colorWithRed:165.0/255.0 green:157.0/255.0 blue:150.0/255.0 alpha:1.0]];
    [detaillb setBackgroundColor:[UIColor clearColor]];
    detaillb.textAlignment = UITextAlignmentLeft;
    detaillb.font=[UIFont fontWithName:@"ArialMT" size:13];
    detaillb.text =[descriptionarray objectAtIndex:indexPath.row];

    [uview addSubview:cellbackground];
    [uview addSubview:cellarrow];
    [uview addSubview:mainlb];
    [uview addSubview:detaillb];
    [cell addSubview:uview];
    [cellarrow release];
    [mainlb release];
    [detaillb release];
    [cellbackground release];
    [uview release];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
     [biographylistingtable deselectRowAtIndexPath:indexPath animated:YES];
   

    BiographyDetailViewController *biodetailview =[[BiographyDetailViewController alloc]initWithNibName:@"BiographyDetailViewController" bundle:nil];
    biodetailview.biographytableselectedid = [biographyidarray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:biodetailview animated:YES];
   // [biodetailview release];
    [biographyidarray removeAllObjects];
    
}

- (void)dealloc {
    [backbtn release];
    [headerlable release];
    [headerlable release];
    [biographylistingtable release];
    [biographylistingtable release];
    [super dealloc];
}
- (IBAction)goback:(id)sender {
    
    
    ViewController *back = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
  
  //  [self.navigationController pushViewController:back animated:YES];
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:back atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
