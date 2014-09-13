//
//  HadithsOfaBookViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 25/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "HadithsOfaBookViewController.h"

@interface HadithsOfaBookViewController ()

@end

@implementation HadithsOfaBookViewController
@synthesize selectedbookid;
@synthesize booktitlelb;
@synthesize hadithcountlb;
@synthesize selectedbooktitle;
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
   
    hadithidarray = [[NSMutableArray alloc]init];
    shorthaditharray = [[NSMutableArray alloc]init];
    hadithnumarray = [[NSMutableArray alloc]init];
    hadithfav = [[NSMutableArray alloc]init];
    hadithcountlb.font = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
    booktitlelb.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    booktitlelb.textAlignment = UITextAlignmentCenter;
    
        // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (searchtextfield.text.length >0) {
        [self gosearch:self];
    }
    else {
        
    
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    NSString *activeyes= @"Y";
    NSString *deleteno = @"N";
    NSString *fav = @"Y";
        FMResultSet *result =[db executeQueryWithFormat: @"SELECT * FROM hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@",selectedbookid,activeyes,deleteno];
        
        while ([result next]) 
        {
            [hadithidarray addObject:[result stringForColumn:@"hadith_id"]];
            [shorthaditharray addObject:[result stringForColumn:@"hadith_title"]];
            [hadithnumarray addObject:[result stringForColumn:@"hadith_num"]];
            [hadithfav addObject:[result stringForColumn:@"hadith_fav"]];
        }
       
    
    FMResultSet *resultforfavcount =[db executeQueryWithFormat: @"SELECT count(hadith_fav) from hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@ and hadith_fav=%@",selectedbookid,activeyes,deleteno,fav];
    NSString *favcount;
    while ([resultforfavcount next])
    {
        
      
        favcount = [NSString stringWithFormat:@"%d",[resultforfavcount intForColumn:@"count(hadith_fav)"]];
        
        
    }
    booktitlelb.text = selectedbooktitle;
    hadithcountlb.text =[NSString stringWithFormat:@"%d %@ %@", [hadithidarray count],NSLocalizedString(@"key9",@"" ),favcount];
    [hadithslistingtableview reloadData];
   
}
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{   
    return [hadithidarray count];
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
    UIView *uview2=[[[UIView alloc]initWithFrame:CGRectMake(0,5,320,70)]autorelease];
    uview2.layer.masksToBounds=YES;
    uview2.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cellbackground =[[UIImageView alloc] initWithFrame:CGRectMake(3,0,313,67)]; 
    cellbackground.image = [UIImage imageNamed:@"bg2.png"];
    
    UIImageView *numbackground =[[UIImageView alloc] initWithFrame:CGRectMake(7,0,21,14)]; 
    numbackground.image = [UIImage imageNamed:@"backred2.png"];
    
    UIImageView *discloser =[[UIImageView alloc] initWithFrame:CGRectMake(290,23,13,21)]; 
    discloser.image = [UIImage imageNamed:@"redarrow.png"];
    
    UILabel *hadithnumlb = [[UILabel alloc]initWithFrame:CGRectMake(0,1,21,14)];
    [hadithnumlb setTextColor:[UIColor whiteColor]];
    [hadithnumlb setBackgroundColor:[UIColor clearColor]];
    hadithnumlb.textAlignment = UITextAlignmentCenter;
    hadithnumlb.adjustsFontSizeToFitWidth = YES;
    hadithnumlb.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    hadithnumlb.text = [hadithnumarray objectAtIndex:indexPath.row];
    
    
    UILabel *hadithdetaillb = [[UILabel alloc]initWithFrame:CGRectMake(10,14,280,45)];
    [hadithdetaillb setTextColor:[UIColor blackColor]];
    [hadithdetaillb setBackgroundColor:[UIColor clearColor]];
    hadithdetaillb.textAlignment = UITextAlignmentLeft;
    hadithdetaillb.numberOfLines = 3;
    hadithdetaillb.font = [UIFont fontWithName:@"ArialMT" size:12];
    hadithdetaillb.text = [shorthaditharray objectAtIndex:indexPath.row];
    
    float x = 0;
    
    if ([[hadithfav objectAtIndex:indexPath.row]isEqual:@"Y"]) 
    {
        UIImageView *star =[[UIImageView alloc] initWithFrame:CGRectMake(30,0,12,14)]; 
        star.image = [UIImage imageNamed:@"Five-star.png"]; 
        x= star.frame.size.width;
        [cellbackground addSubview:star];
    
    }
    
    
    UILabel *selonlb = [[UILabel alloc]initWithFrame:CGRectMake(x+33,0,40,16)];
    [selonlb setTextColor:[UIColor colorWithRed:165.0/255.0 green:157.0/255.0 blue:150.0/255.0 alpha:1.0]];
    [selonlb setBackgroundColor:[UIColor clearColor]];
    selonlb.textAlignment = UITextAlignmentLeft;
    selonlb.font = [UIFont fontWithName:@"ArialMT" size:12];
    selonlb.text = NSLocalizedString(@"key14",@"" );
    
    

   NSString * tempbioid;
   NSMutableArray *biotitle = [[NSMutableArray alloc]init];
   NSMutableArray *biodesc = [[NSMutableArray alloc]init]; 
   
           
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
   
        FMResultSet *result =[db executeQueryWithFormat: @"select * from hadith_chain where hadith_id=%@",[hadithidarray objectAtIndex:indexPath.row]];
    
      while ([result next]) 
        { 
        
            tempbioid =[result stringForColumn:@"biography_id"];
            
         
        FMResultSet *results =[db executeQueryWithFormat: @"select * from biography_master where biography_id=%@",tempbioid];
            while ([results next]) 
            {
                
               [biotitle addObject:[results stringForColumn:@"title"]];
               [biodesc addObject:[results stringForColumn:@"description"]];
                             
             
            }
            // NSLog(@"hadith id---->%@.. biography title -> %@",[hadithidarray objectAtIndex:indexPath.row],biotitle);
            
        }  
            UILabel *biotitlelb = [[UILabel alloc]initWithFrame:CGRectMake(x+68,0,100,16)];
            [biotitlelb setTextColor:[UIColor colorWithRed:187.0/255.0 green:44.0/255.0 blue:61.0/255.0 alpha:1.0]];
            [biotitlelb setBackgroundColor:[UIColor clearColor]];
            biotitlelb.textAlignment = UITextAlignmentLeft;
            biotitlelb.font = [UIFont fontWithName:@"ArialMT" size:12]; 
            biotitlelb.text = [biotitle lastObject];
            CGSize textSize = [[biotitle lastObject] sizeWithFont:[UIFont fontWithName:@"ArialMT" size:12]];
            
            CGFloat strikeWidth = textSize.width;
            
            if (strikeWidth > biotitlelb.frame.size.width) {
                
                UILabel *biotitledesc = [[UILabel alloc]initWithFrame:CGRectMake(x+170,0,130,16)];
                [biotitledesc setTextColor:[UIColor colorWithRed:165.0/255.0 green:157.0/255.0 blue:150.0/255.0 alpha:1.0]];;
                [biotitledesc setBackgroundColor:[UIColor clearColor]];
                biotitledesc.textAlignment = UITextAlignmentLeft;
                biotitledesc.font = [UIFont fontWithName:@"ArialMT" size:12]; 
                biotitledesc.text = [biodesc lastObject];
                [cellbackground addSubview:biotitlelb];
                [cellbackground addSubview:biotitledesc];
                [biotitlelb release];
            }
            else {
                UILabel *biotitledesc = [[UILabel alloc]initWithFrame:CGRectMake(x+strikeWidth+70,0,145,16)];
                [biotitledesc setTextColor:[UIColor colorWithRed:165.0/255.0 green:157.0/255.0 blue:150.0/255.0 alpha:1.0]];;
                [biotitledesc setBackgroundColor:[UIColor clearColor]];
                biotitledesc.textAlignment = UITextAlignmentLeft;
                biotitledesc.font = [UIFont fontWithName:@"ArialMT" size:12]; 
                biotitledesc.text = [biodesc lastObject];
                [cellbackground addSubview:biotitlelb];
                [cellbackground addSubview:biotitledesc];
                [biotitlelb release];
                
                
            }

    [db close];
    [numbackground addSubview:hadithnumlb];
    [cellbackground addSubview:selonlb];
    [cellbackground addSubview:hadithdetaillb];
    [cellbackground addSubview:numbackground];
    [cellbackground addSubview:discloser];
    [uview2 addSubview:cellbackground];
    [cell addSubview:uview2];
   
   
    
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [hadithslistingtableview deselectRowAtIndexPath:indexPath animated:YES];
    
    HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
    
    gotohadithdetail.selectedbooktitle = selectedbooktitle;
    gotohadithdetail.selectedhadithid = [hadithidarray objectAtIndex:indexPath.row];
    gotohadithdetail.i = indexPath.row;
    gotohadithdetail.hadithidforcounarray = [[NSMutableArray alloc]initWithArray:hadithidarray];
    [self.navigationController pushViewController:gotohadithdetail animated:YES];
    [hadithidarray removeAllObjects];
    [hadithfav removeAllObjects];
    
}


- (void)viewDidUnload
{
    [hadithslistingtableview release];
    hadithslistingtableview = nil;
    [backbtn release];
    backbtn = nil;
    [booktitlelb release];
    booktitlelb = nil;
    [self setBooktitlelb:nil];
    [self setHadithcountlb:nil];
    [searchtextfield release];
    searchtextfield = nil;
    [searchbt release];
    searchbt = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc {
    [hadithslistingtableview release];
    [backbtn release];
    [booktitlelb release];
    [booktitlelb release];
    [hadithcountlb release];
    [searchtextfield release];
    [searchbt release];
    [super dealloc];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)typedone:(id)sender {
    [hadithidarray removeAllObjects];
    [shorthaditharray removeAllObjects];
    [hadithnumarray removeAllObjects];
    [hadithfav removeAllObjects];
    
    if (searchtextfield.text.length >0)
    {
        
        NSString *p = @"%";
       
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT * FROM hadith_master WHERE hadith_master.book_id =%@ and hadith_master.hadith_title LIKE'%@%@%@%@%@%@%@%@%@'",selectedbookid,p,p,p,p,searchtextfield.text,p,p,p,p]];
        
        while ([results next]) 
        {
            [hadithidarray addObject:[results stringForColumn:@"hadith_id"]];
            [shorthaditharray addObject:[results stringForColumn:@"hadith_title"]];
            [hadithnumarray addObject:[results stringForColumn:@"hadith_num"]];
            [hadithfav addObject:[results stringForColumn:@"hadith_fav"]];
        }
        
        [hadithslistingtableview reloadData];
        
    }
    else {
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        NSString *activeyes= @"Y";
        NSString *deleteno = @"N";
        FMResultSet *result =[db executeQueryWithFormat: @"SELECT * FROM hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@",selectedbookid,activeyes,deleteno];
        
        while ([result next]) 
        {
            [hadithidarray addObject:[result stringForColumn:@"hadith_id"]];
            [shorthaditharray addObject:[result stringForColumn:@"hadith_title"]];
            [hadithnumarray addObject:[result stringForColumn:@"hadith_num"]];
            [hadithfav addObject:[result stringForColumn:@"hadith_fav"]];
        }
        
        
        
        [hadithslistingtableview reloadData];
        
        
        
    }
}



- (IBAction)crossbt:(id)sender {
    
    if (searchtextfield.text.length >0) {
        searchtextfield.text = @"";
        [self gosearch:sender];
    }

}

- (IBAction)gosearch:(id)sender {
    
    [searchtextfield resignFirstResponder];
    [hadithidarray removeAllObjects];
    [shorthaditharray removeAllObjects];
    [hadithnumarray removeAllObjects];
    [hadithfav removeAllObjects];

    if (searchtextfield.text.length >0)
    {
       
        NSString *p = @"%";
      
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT * FROM hadith_master WHERE hadith_master.book_id =%@ and hadith_master.hadith_title LIKE'%@%@%@%@%@%@%@%@%@'",selectedbookid,p,p,p,p,searchtextfield.text,p,p,p,p]];
         
        while ([results next]) 
        {
            [hadithidarray addObject:[results stringForColumn:@"hadith_id"]];
            [shorthaditharray addObject:[results stringForColumn:@"hadith_title"]];
            [hadithnumarray addObject:[results stringForColumn:@"hadith_num"]];
            [hadithfav addObject:[results stringForColumn:@"hadith_fav"]];
        }
        
         [hadithslistingtableview reloadData];

    }
    else {
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        NSString *activeyes= @"Y";
        NSString *deleteno = @"N";
        FMResultSet *result =[db executeQueryWithFormat: @"SELECT * FROM hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@",selectedbookid,activeyes,deleteno];
        
        while ([result next]) 
        {
            [hadithidarray addObject:[result stringForColumn:@"hadith_id"]];
            [shorthaditharray addObject:[result stringForColumn:@"hadith_title"]];
            [hadithnumarray addObject:[result stringForColumn:@"hadith_num"]];
            [hadithfav addObject:[result stringForColumn:@"hadith_fav"]];
        }
        
        
               
        [hadithslistingtableview reloadData];

        
        
    }
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
