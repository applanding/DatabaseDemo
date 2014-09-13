//
//  FavouriteViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "FavouriteViewController.h"

@interface FavouriteViewController ()

@end

@implementation FavouriteViewController
@synthesize searchtextfield;
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
    book_bookidarray = [[NSMutableArray alloc]init];
    book_booktitlearray =[[NSMutableArray alloc]init];
    hadith_hadithidarray =[[NSMutableArray alloc]init];
    hadith_hadithnumarray =[[NSMutableArray alloc]init];
    hadith_shortdescarray =[[NSMutableArray alloc]init];
    hadith_iddict =[[NSMutableDictionary alloc]init];
    hadith_numdict= [[NSMutableDictionary alloc]init];
    shorthadith_dict= [[NSMutableDictionary alloc]init];
    hadith_idcount = [[NSMutableArray alloc]init];
   

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{

    if (searchtextfield.text.length > 0) {
        [self textfieldtype:self];
    }
    else {
        
    activeyes= @"Y";
    deleteno = @"N";
    
    NSString *temp =[NSString stringWithFormat:@"0"];
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    FMResultSet *forcount = [db executeQueryWithFormat:@"SELECT count(book_master.book_id) from hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_fav=%@ order by book_master.book_id",activeyes];
    
    while([forcount next]) 
    {
        
       
        if ([forcount intForColumn:@"count(book_master.book_id)"]>0 ) 
        {
    
            FMResultSet *results = [db executeQueryWithFormat:@"SELECT book_master.book_id,book_master.title FROM hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_fav=%@ order by book_master.book_id",activeyes];
            while ([results next]) 
            {
                if (![temp isEqualToString:[results stringForColumn:@"book_id"]])
                {
        
            [book_bookidarray addObject:[results stringForColumn:@"book_id"]];
            [book_booktitlearray addObject:[results stringForColumn:@"title"]];
            temp = [results stringForColumn:@"book_id"];
                }
            }
        }
    }
    if ([book_bookidarray count]==0) {
        
        UILabel *mainlb = [[UILabel alloc]initWithFrame:CGRectMake(40,150,270,29)];
        [mainlb setTextColor:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]];
        [mainlb setBackgroundColor:[UIColor clearColor]];
        mainlb.textAlignment = UITextAlignmentLeft;
        mainlb.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
        mainlb.text = NSLocalizedString(@"key16",@"" );
        [self.view addSubview:mainlb];
        [mainlb release];
        
    }
    
  
    [self fillarrays];
    } 
    
}
-(void)fillarrays{
    
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    for (i=0; i<[book_bookidarray count]; i++) 
    {
        hadith_shortdescarray = [[NSMutableArray alloc]init];
        hadith_hadithidarray = [[NSMutableArray alloc]init];
        hadith_hadithnumarray = [[NSMutableArray alloc]init];
        
        
        
    FMResultSet *result1 =[db executeQueryWithFormat:@"SELECT count(hadith_id) FROM hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@",[book_bookidarray objectAtIndex:i],activeyes,deleteno];
        
        while ([result1 next]) 
        {
            
    [hadith_idcount addObject:[NSString stringWithFormat:@"%d",[result1 intForColumn:@"count(hadith_id)"]]];                
            
        }
      

    FMResultSet *result =[db executeQueryWithFormat:@"SELECT * FROM hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@ and hadith_fav=%@ ",[book_bookidarray objectAtIndex:i],activeyes,deleteno,activeyes];
    
    while ([result next]) 
    {
        
        [hadith_hadithidarray addObject:[result stringForColumn:@"hadith_id"]];
        [hadith_shortdescarray addObject:[result stringForColumn:@"hadith_title"]];
        [hadith_hadithnumarray addObject:[result stringForColumn:@"hadith_num"]];
        
    }
    
    [hadith_iddict setObject:hadith_hadithidarray forKey:[NSString stringWithFormat:@"%d",i]];
    [shorthadith_dict setObject:hadith_shortdescarray forKey:[NSString stringWithFormat:@"%d",i]]; 
    [hadith_numdict setObject:hadith_hadithnumarray forKey:[NSString stringWithFormat:@"%d",i]];
        
    }
    [favhadithtableview reloadData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie
{
    
    
    return [book_bookidarray count];
   

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
      UIView *uview=[[[UIView alloc]initWithFrame:CGRectMake(0,3,320,45)]autorelease];
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
        livrenum.text = [book_bookidarray objectAtIndex:section];
        
        
        UIImageView *detailback =[[UIImageView alloc] initWithFrame:CGRectMake(50,2,267,41)]; 
        detailback.image=[[UIImage alloc]init];
        detailback.image = [UIImage imageNamed:@"row.png"];
        
        UILabel *hadithcount = [[UILabel alloc]initWithFrame:CGRectMake(25,0,210,24)];
        [hadithcount setBackgroundColor:[UIColor clearColor]];
        [hadithcount setTextColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
        hadithcount.font = [UIFont fontWithName:@"Arial-ItalicMT" size:10];
        hadithcount.text = [NSString stringWithFormat:@"%@ %@ %d",[hadith_idcount objectAtIndex:section],NSLocalizedString(@"key9",@"" ),[[hadith_iddict objectForKey:[NSString stringWithFormat:@"%d",section]]count]];
        
        UILabel *booktitle = [[UILabel alloc]initWithFrame:CGRectMake(20,10,210,30)];
        [booktitle setTextColor:[UIColor blackColor]];
        [booktitle setBackgroundColor:[UIColor clearColor]];
        booktitle.textAlignment = UITextAlignmentLeft;
        booktitle.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        booktitle.text = [book_booktitlearray objectAtIndex:section];
        
        [numbackground addSubview:livrelb];
        [numbackground addSubview:livrenum];
        [detailback addSubview:booktitle];
        [detailback addSubview:hadithcount];
        [uview addSubview:numbackground];
        [uview addSubview:detailback];
        
    
    return uview;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    int sectionheight = 0;
    
        sectionheight = 50;
        favhadithtableview .sectionHeaderHeight = sectionheight;
    
    return sectionheight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 0;
        cellHeight = 72;
        favhadithtableview.rowHeight = cellHeight;
        
    return cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
        return [[hadith_iddict objectForKey:[NSString stringWithFormat:@"%d",section]]count];
    
    
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
    
    UIView *uview2=[[[UIView alloc]initWithFrame:CGRectMake(0,0,320,70)]autorelease];
    uview2.layer.masksToBounds=YES;
    uview2.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cellbackground =[[UIImageView alloc] initWithFrame:CGRectMake(5,0,313,67)]; 
    cellbackground.image = [UIImage imageNamed:@"bg2.png"];
    
    UIImageView *numbackground =[[UIImageView alloc] initWithFrame:CGRectMake(7,0,21,14)]; 
    numbackground.image = [UIImage imageNamed:@"backred2.png"];
    
    UIImageView *discloser =[[UIImageView alloc] initWithFrame:CGRectMake(290,23,13,21)]; 
    discloser.image = [UIImage imageNamed:@"redarrow.png"];
    
    UILabel *hadithnumlb = [[UILabel alloc]initWithFrame:CGRectMake(0,0,21,14)];
    [hadithnumlb setTextColor:[UIColor whiteColor]];
    [hadithnumlb setBackgroundColor:[UIColor clearColor]];
    hadithnumlb.textAlignment = UITextAlignmentCenter;
    hadithnumlb.font = [UIFont fontWithName:@"Arial-BoldMT" size:10];
    hadithnumlb.text = [[NSArray arrayWithArray:[hadith_numdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
    
    
    UILabel *hadithdetaillb = [[UILabel alloc]initWithFrame:CGRectMake(10,14,280,45)];
    [hadithdetaillb setTextColor:[UIColor blackColor]];
    [hadithdetaillb setBackgroundColor:[UIColor clearColor]];
    hadithdetaillb.textAlignment = UITextAlignmentLeft;
    hadithdetaillb.numberOfLines = 3;
    hadithdetaillb.adjustsFontSizeToFitWidth = YES;
    hadithdetaillb.font = [UIFont fontWithName:@"ArialMT" size:12];
    hadithdetaillb.text = [[NSArray arrayWithArray:[shorthadith_dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
    
    float x = 0;
        
    UIImageView *star =[[UIImageView alloc] initWithFrame:CGRectMake(30,0,12,14)]; 
    star.image = [UIImage imageNamed:@"Five-star.png"]; 
    x= star.frame.size.width;
    [cellbackground addSubview:star];
        
    
    
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
    
    FMResultSet *result =[db executeQueryWithFormat: @"select * from hadith_chain where hadith_id=%@",[[NSArray arrayWithArray:[hadith_iddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row]];
    
    while ([result next]) 
    { 
        
        tempbioid =[result stringForColumn:@"biography_id"];
        
        
        FMResultSet *results =[db executeQueryWithFormat: @"select * from biography_master where biography_id=%@",tempbioid];
        while ([results next]) 
        {
            
            [biotitle addObject:[results stringForColumn:@"title"]];
            [biodesc addObject:[results stringForColumn:@"description"]];
            
            
        }
    }
       
        
        if ([biotitle count]!=0) {
            
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
    } 
    
    [db close];
    
    [numbackground addSubview:hadithnumlb];
    [cellbackground addSubview:selonlb];
    [cellbackground addSubview:hadithdetaillb];
    [cellbackground addSubview:numbackground];
    [cellbackground addSubview:discloser];
    [uview2 addSubview:cellbackground];
    [cell addSubview:uview2];
    
    // cell.textLabel.text = [[NSArray arrayWithArray:[hadithdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
    
   
return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [favhadithtableview deselectRowAtIndexPath:indexPath animated:YES];
    HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
    gotohadithdetail.selectedbooktitle = [book_booktitlearray objectAtIndex:indexPath.section];
    gotohadithdetail.hadithidforcounarray = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithArray:[hadith_iddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]];
    gotohadithdetail.selectedhadithid = [[NSArray arrayWithArray:[hadith_iddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
    gotohadithdetail.i = indexPath.row;
    [self.navigationController pushViewController:gotohadithdetail animated:YES];
    [hadith_iddict removeAllObjects];
    [book_bookidarray removeAllObjects];

    
}


- (void)viewDidUnload
{
    [backbtn release];
    backbtn = nil;
    [favhadithtableview release];
    favhadithtableview = nil;
    [self setSearchtextfield:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)textfieldtype:(id)sender {
    
    [book_bookidarray removeAllObjects];
    [book_booktitlearray removeAllObjects];
    [hadith_hadithidarray removeAllObjects];
    [hadith_hadithnumarray removeAllObjects];
    [hadith_shortdescarray removeAllObjects];
    [hadith_idcount removeAllObjects];
    [hadith_iddict removeAllObjects];
    [hadith_numdict removeAllObjects];
    [shorthadith_dict removeAllObjects];
   
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
     NSString *temp =[NSString stringWithFormat:@"0"];
    
    if (searchtextfield.text.length >0) 
    {
        
       
        FMResultSet *forcount = [db executeQuery:@"SELECT count(book_master.book_id) from hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_fav=? order by book_master.book_id",[NSString stringWithFormat:@"%@",activeyes]];
        
        while([forcount next]) 
        {
            
          
            if ([forcount intForColumn:@"count(book_master.book_id)"]>0 ) 
            {

        FMResultSet *results = [db executeQuery: @"SELECT book_master.book_id,book_master.title FROM hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_fav=? and( hadith_master.hadith_title LIKE ? or book_master.title LIKE ?) order by book_master.book_id",[NSString stringWithFormat:@"%@",activeyes],[NSString stringWithFormat:@"%%%@%%", searchtextfield.text],[NSString stringWithFormat:@"%%%@%%", searchtextfield.text]];
      
        while ([results next]) 
        {
            
            
            if (![temp isEqualToString:[results stringForColumn:@"book_id"]])
            {
                
                [book_bookidarray addObject:[results stringForColumn:@"book_id"]];
                [book_booktitlearray addObject:[results stringForColumn:@"title"]];
                temp = [results stringForColumn:@"book_id"];
                
            }
        }
    }
        }
       
        [self fillarrays];

    }
    else 
    {
        
        NSString *temp =[NSString stringWithFormat:@"0"];
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        FMResultSet *forcount = [db executeQueryWithFormat:@"SELECT count(book_master.book_id) from hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_fav=%@ order by book_master.book_id",activeyes];
        
        while([forcount next]) 
        {
            
           
            if ([forcount intForColumn:@"count(book_master.book_id)"]>0 ) 
            {
                
                FMResultSet *results = [db executeQueryWithFormat:@"SELECT book_master.book_id,book_master.title FROM hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_fav=%@ order by book_master.book_id",activeyes];
                while ([results next]) 
                {
                    if (![temp isEqualToString:[results stringForColumn:@"book_id"]])
                    {
                        
                        [book_bookidarray addObject:[results stringForColumn:@"book_id"]];
                        [book_booktitlearray addObject:[results stringForColumn:@"title"]];
                        temp = [results stringForColumn:@"book_id"];
                    }
                }
            }
        }
        if ([book_bookidarray count]==0) {
            
            UILabel *mainlb = [[UILabel alloc]initWithFrame:CGRectMake(40,150,270,29)];
            [mainlb setTextColor:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]];
            [mainlb setBackgroundColor:[UIColor clearColor]];
            mainlb.textAlignment = UITextAlignmentLeft;
            mainlb.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
            mainlb.text = NSLocalizedString(@"key16",@"" );
            [self.view addSubview:mainlb];
            [mainlb release];
            
        }
        
       
        [self fillarrays];
    }    
    
    
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
    [favhadithtableview release];
    [searchtextfield release];
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
