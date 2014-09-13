//
//  SearchViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize noresultlb;
@synthesize searchtextfield;
bool search;
int i;
int count=0;
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
    bookidarr = [[NSMutableArray alloc]init];
    booktitlearr = [[NSMutableArray alloc]init];
    hadithidarr = [[NSMutableArray alloc]init];
    hadithnumarr = [[NSMutableArray alloc]init];
    hadithtitle = [[NSMutableArray alloc]init];
    hadithiddict = [[NSMutableDictionary alloc]init];
    hadithnumdict = [[NSMutableDictionary alloc]init];
    hadithtitledict = [[NSMutableDictionary alloc]init];
    noresultlb.text = NSLocalizedString(@"key13",@"" );
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self gosearch:self];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if (search == YES) {
        return [bookidarr count];
        
    }
    else {
        return 0;
        
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
       UIView *uview=[[[UIView alloc]initWithFrame:CGRectMake(0,20,320,45)]autorelease];
        uview.layer.masksToBounds=YES;
        uview.backgroundColor = [UIColor whiteColor];
        UIImageView *numbackground =[[UIImageView alloc] initWithFrame:CGRectMake(5,3,41,41)]; 
        numbackground.image=[[UIImage alloc]init];
        numbackground.image = [UIImage imageNamed:@"rownum.png"];
        
        UILabel *livrelb = [[UILabel alloc]initWithFrame:CGRectMake(0,4,41,10)];
        [livrelb setTextColor:[UIColor blackColor]];
        [livrelb setBackgroundColor:[UIColor clearColor]];
        livrelb.textAlignment = UITextAlignmentCenter;
        livrelb.font = [UIFont fontWithName:@"ArialMT" size:12];
        livrelb.text = NSLocalizedString(@"key12",@"" );
        
        UILabel *livrenum = [[UILabel alloc]initWithFrame:CGRectMake(0,10,41,30)];
        [livrenum setTextColor:[UIColor blackColor]];
        [livrenum setBackgroundColor:[UIColor clearColor]];
        livrenum.textAlignment = UITextAlignmentCenter;
        livrenum.font = [UIFont fontWithName:@"ArialMT" size:27];
        livrenum.text = [bookidarr objectAtIndex:section];
        
        
        UIImageView *detailback =[[UIImageView alloc] initWithFrame:CGRectMake(49,2,266,41)]; 
        detailback.image=[[UIImage alloc]init];
        detailback.image = [UIImage imageNamed:@"row.png"];
        
        UILabel *hadithcount = [[UILabel alloc]initWithFrame:CGRectMake(25,0,200,24)];
        [hadithcount setBackgroundColor:[UIColor clearColor]];
        hadithcount.textAlignment = UITextAlignmentLeft;
        [hadithcount setTextColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
        hadithcount.font = [UIFont fontWithName:@"Arial-ItalicMT" size:10];
        hadithcount.text = [hadithcountarr objectAtIndex:section]; 
        hadithcount.text = [NSString stringWithFormat:@"%@ %@ %@",[hadithcountarr objectAtIndex:section],NSLocalizedString(@"key9",@"" ),[hadithfavcountarr objectAtIndex:section]] ;
    
    
      
        
    
        UILabel *booktitle = [[UILabel alloc]initWithFrame:CGRectMake(20,10,210,30)];
        [booktitle setTextColor:[UIColor blackColor]];
        [booktitle setBackgroundColor:[UIColor clearColor]];
        booktitle.textAlignment = UITextAlignmentLeft;
        booktitle.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        booktitle.text = [booktitlearr objectAtIndex:section];
        
        [numbackground addSubview:livrelb];
        [numbackground addSubview:livrenum];
        [detailback addSubview:booktitle];
        [detailback addSubview:hadithcount];
        [uview addSubview:numbackground];
        [uview addSubview:detailback];
        
    
    return uview;
    
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{   
    if (search == YES) {
        
    return [[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",section]] count];
    }
    else {
        return 0;
    }
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
        
    
        UIView *uview2=[[[UIView alloc]initWithFrame:CGRectMake(3,0,313,32)]autorelease];
        uview2.layer.masksToBounds=YES;
        uview2.backgroundColor = [UIColor whiteColor];

        UIImageView *cellbackground =[[UIImageView alloc] initWithFrame:CGRectMake(2,0,310,32)]; 
        cellbackground.image = [UIImage imageNamed:@"img.jpg"];
    
        UIImageView *numbackground =[[UIImageView alloc] initWithFrame:CGRectMake(5,0,21,14)]; 
        numbackground.image = [UIImage imageNamed:@"backred2.png"];
        
    
        UILabel *hadithnumlb = [[UILabel alloc]initWithFrame:CGRectMake(0,0,21,14)];
        [hadithnumlb setTextColor:[UIColor whiteColor]];
        [hadithnumlb setBackgroundColor:[UIColor clearColor]];
        hadithnumlb.textAlignment = UITextAlignmentCenter;
        hadithnumlb.font = [UIFont fontWithName:@"Arial-BoldMT" size:10];
        hadithnumlb.text = [[NSArray arrayWithArray:[hadithnumdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
        hadithnumlb.text = [[NSArray arrayWithArray:[hadithnumdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
   
        UILabel *hadithdetaillb = [[UILabel alloc]initWithFrame:CGRectMake(10,11,280,20)];
        [hadithdetaillb setTextColor:[UIColor blackColor]];
        [hadithdetaillb setBackgroundColor:[UIColor clearColor]];
        hadithdetaillb.textAlignment = UITextAlignmentLeft;
        hadithdetaillb.font = [UIFont fontWithName:@"ArialMT" size:12];
        hadithdetaillb.text = [[NSArray arrayWithArray:[hadithtitledict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
    
        [numbackground addSubview:hadithnumlb];
        [cellbackground addSubview:hadithdetaillb];
        [cellbackground addSubview:numbackground];
        [uview2 addSubview:cellbackground];
        [cell addSubview:uview2];
    
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
        [searchtableview deselectRowAtIndexPath:indexPath animated:YES];
    HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
    gotohadithdetail.selectedbooktitle = [booktitlearr objectAtIndex:indexPath.section];
    gotohadithdetail.hadithidforcounarray = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]];
    gotohadithdetail.selectedhadithid = [[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
    gotohadithdetail.i = indexPath.row;
    [self.navigationController pushViewController:gotohadithdetail animated:YES];
    
}

    
- (IBAction)editingend:(id)sender {
    if(searchtextfield.text.length == 0){
        search= NO;
        searchtextfield.text =@"";
        noresultlb.text = NSLocalizedString(@"key13",@"" );
    }
    
    else {
        search = YES;
        [self gosearch:sender];
    }
    [searchtableview reloadData];
}


- (void)viewDidUnload
{
    [backbtn release];
    backbtn = nil;
    [searchtableview release];
    searchtableview = nil;
    [searchtextfield release];
    searchtextfield = nil;
    [self setSearchtextfield:nil];
    [searchbt release];
    searchbt = nil;
    [self setNoresultlb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc {
    [backbtn release];
    [searchtableview release];
    [searchtextfield release];
    [searchtextfield release];
    [searchbt release];
    [noresultlb release];
    
    [super dealloc];
}
- (IBAction)crossbtn:(id)sender {
    if (searchtextfield.text.length > 0) {
        searchtextfield.text = @"";
        search= NO;
        noresultlb.text = NSLocalizedString(@"key13",@"" );
        
    }
    [searchtableview reloadData];
    
}

- (IBAction)goback:(id)sender {
    ViewController *back = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    
    //  [self.navigationController pushViewController:back animated:YES];
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:back atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)gosearch:(id)sender {
    [searchtextfield resignFirstResponder];
    
    if (searchtextfield.text.length >0) 
    {
        NSString *temp =[NSString stringWithFormat:@"0"];
        search = YES;
        
    
        [bookidarr removeAllObjects];
        [booktitlearr removeAllObjects];
        [hadithidarr removeAllObjects];
       [hadithnumarr removeAllObjects];
        [hadithtitle removeAllObjects];
       [hadithiddict removeAllObjects];
        [hadithnumdict removeAllObjects];
       [hadithtitledict removeAllObjects];
        
      
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 

    FMResultSet *results = [db executeQuery:@"SELECT hadith_master.book_id, hadith_master.hadith_num, hadith_master.hadith_id, hadith_master.hadith_title,book_master.title FROM hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_title LIKE ? or book_master.title LIKE ? order by book_master.book_id",[NSString stringWithFormat:@"%%%@%%", searchtextfield.text],[NSString stringWithFormat:@"%%%@%%", searchtextfield.text]];
     i=0; 
     count=0;   
    while ([results next]) 
    {
        count++;
         
        if (![temp isEqualToString:[results stringForColumn:@"book_id"]]) 
        {
            hadithidarr = [[NSMutableArray alloc]init];
            hadithnumarr = [[NSMutableArray alloc]init];
            hadithtitle =[[NSMutableArray alloc]init];
            [bookidarr addObject:[results stringForColumn:@"book_id"]];
            [booktitlearr addObject:[results stringForColumn:@"title"]];
            [hadithidarr addObject:[results stringForColumn:@"hadith_id"]];
            [hadithnumarr addObject:[results stringForColumn:@"hadith_num"]];
            [hadithtitle addObject:[results stringForColumn:@"hadith_title"]];
            [hadithiddict setObject:hadithidarr forKey:[NSString stringWithFormat:@"%d",i]];
            [hadithnumdict setObject:hadithnumarr forKey:[NSString stringWithFormat:@"%d",i]];
            [hadithtitledict setObject:hadithtitle forKey:[NSString stringWithFormat:@"%d",i]];
            temp = [results stringForColumn:@"book_id"];
             i++;
           
        }
        else 
        {
           
            [hadithidarr addObject:[results stringForColumn:@"hadith_id"]];
            [hadithnumarr addObject:[results stringForColumn:@"hadith_num"]];
            [hadithtitle addObject:[results stringForColumn:@"hadith_title"]];
            [hadithiddict setObject:hadithidarr forKey:[NSString stringWithFormat:@"%d",i-1]];
            [hadithnumdict setObject:hadithnumarr forKey:[NSString stringWithFormat:@"%d",i-1]];
            [hadithtitledict setObject:hadithtitle forKey:[NSString stringWithFormat:@"%d",i-1]];
            temp = [results stringForColumn:@"book_id"];
            
        }
         
     
        
    }
       
    
    
     noresultlb.text = [NSString stringWithFormat:@"%d %@ %d %@",count,NSLocalizedString(@"key11",@"" ),[bookidarr count],NSLocalizedString(@"key15",@"" )];
    }
    int j=0;
        hadithfavcountarr = [[NSMutableArray alloc]init];
    hadithcountarr = [[NSMutableArray alloc]init];
    NSString *yes = @"Y";
    for (j=0; j<[bookidarr count]; j++) {
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 

       
        FMResultSet *resultforfavcount =[db executeQueryWithFormat: @"SELECT count(hadith_fav) from hadith_master where book_id=%@ and hadith_fav=%@",[bookidarr objectAtIndex:j],yes];
        
        while ([resultforfavcount next])
        {
            
               
            [hadithfavcountarr addObject:[NSString stringWithFormat:@"%d",[resultforfavcount intForColumn:@"count(hadith_fav)"]]];
        }
        
        FMResultSet *totalhadith =[db executeQueryWithFormat: @"SELECT count(hadith_id) from hadith_master where book_id=%@",[bookidarr objectAtIndex:j]];
        
        while ([totalhadith next])
        {
            
           
            [hadithcountarr addObject:[NSString stringWithFormat:@"%d",[totalhadith intForColumn:@"count(hadith_id)"]]];
        }

        
    }

        [searchtableview reloadData];
    }
@end
