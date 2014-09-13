//
//  HadithsViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "HadithsViewController.h"


@interface HadithsViewController ()

@end

@implementation HadithsViewController
@synthesize searchtextfield;

int i;
NSString *activeyes= @"Y";
NSString *deleteno = @"N";
NSString *fav = @"Y";

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
    liverbt.userInteractionEnabled = NO;
    [liverbt setBackgroundImage:[UIImage imageNamed:@"livers1.png"] forState:UIControlStateNormal];
    [hadithbt setBackgroundImage:[UIImage imageNamed:@"hadith2.png"] forState:UIControlStateNormal];
    listingtableview.tag = 1;
    [backbt addTarget:self.navigationController.parentViewController
               action:@selector(revealToggle:)
     forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{

    bookmaster_bookidarray= [[NSMutableArray alloc]init];
    bookmaster_booktitlearray = [[NSMutableArray alloc]init];
    hadithiddict = [[NSMutableDictionary alloc]init];
    shorthadithdict = [[NSMutableDictionary alloc]init];
    hadithnumdict = [[NSMutableDictionary alloc]init];
    hadithfavdict = [[NSMutableDictionary alloc]init];
    hadithfavcountarray = [[NSMutableArray alloc]init];
    if(searchtextfield.text.length >0){
        
        [self searchingstart:self];
    }
    else {
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    FMResultSet *forcount = [db executeQueryWithFormat:@"SELECT count(book_id) from book_master"];

    while([forcount next]) 
    {
        
        
        if ([forcount intForColumn:@"count(book_id)"]>0 ) 
        {
 
        
            FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM book_master where is_active=%@ and is_deleted=%@",activeyes,deleteno];
    
            while ([results next])
            {
        
                [bookmaster_bookidarray addObject:[results stringForColumn:@"book_id"]];
                [bookmaster_booktitlearray addObject:[results stringForColumn:@"title"]];
        
            }
        }
    } 
[db close];
[self fillarrays];
    }
}  

-(void)fillarrays{
   
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    for (i=0; i<[bookmaster_bookidarray count]; i++) 
    {
        hadithmaster_shortdescarray = [[NSMutableArray alloc]init];
        hadithmaster_hadithidarray = [[NSMutableArray alloc]init];
        hadithmaster_hadithnumarray = [[NSMutableArray alloc]init];
        hadithmaster_hadithfav = [[NSMutableArray alloc]init];
       
      
     FMResultSet *result1 =[db executeQueryWithFormat:@"SELECT * FROM hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@",[bookmaster_bookidarray objectAtIndex:i],activeyes,deleteno];

         
        while ([result1 next]) 
        {
            
        [hadithmaster_hadithidarray addObject:[result1 stringForColumn:@"hadith_id"]];
           // NSLog(@"\\\\---->%@",[result1 stringForColumn:@"hadith_id"] );
        [hadithmaster_shortdescarray addObject:[result1 stringForColumn:@"hadith_title"]];
        [hadithmaster_hadithnumarray addObject:[result1 stringForColumn:@"hadith_num"]];
        [hadithmaster_hadithfav addObject:[result1 stringForColumn:@"hadith_fav"]];    
            
        }
       // NSLog(@"-----%@", hadithmaster_hadithidarray );
        [hadithiddict setObject:hadithmaster_hadithidarray forKey:[NSString stringWithFormat:@"%d",i]];
        [shorthadithdict setObject:hadithmaster_shortdescarray forKey:[NSString stringWithFormat:@"%d",i]]; 
        [hadithnumdict setObject:hadithmaster_hadithnumarray forKey:[NSString stringWithFormat:@"%d",i]];
        [hadithfavdict setObject:hadithmaster_hadithfav forKey:[NSString stringWithFormat:@"%d",i]];
      //  NSLog(@"-----%@", shorthadithdict);
       
        FMResultSet *resultforfavcount =[db executeQueryWithFormat: @"SELECT count(hadith_fav) from hadith_master where book_id=%@ and is_active=%@ and is_deleted=%@ and hadith_fav=%@",[bookmaster_bookidarray objectAtIndex:i],activeyes,deleteno,fav];
    
        while ([resultforfavcount next])
        {
            
         //   NSLog(@"count(hadithfav->%d",[resultforfavcount intForColumn:@"count(hadith_fav)"]);
            [hadithfavcountarray addObject:[NSString stringWithFormat:@"%d",[resultforfavcount intForColumn:@"count(hadith_fav)"]]];
        }
           
    // NSLog(@"hadith%@",hadithnumdict);
    }

    [db close];
    [listingtableview reloadData];
}

- (void)viewDidUnload
{
    [liverbt release];
    liverbt = nil;
    [hadithbt release];
    hadithbt = nil;
    [self setSearchtextfield:nil];
    [listingtableview release];
    listingtableview = nil;
    [backbt release];
    backbt = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    
    if (listingtableview.tag == 1) {
        

        return 1;
    }
    else {
       

                
        return [bookmaster_bookidarray count];
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    if (listingtableview.tag==1) {
        uview=[[[UIView alloc]initWithFrame:CGRectMake(0,0,320,1)]autorelease];
        uview.layer.masksToBounds=YES;
        uview.backgroundColor = [UIColor whiteColor];
        
    }
    else 
    {
        uview=[[[UIView alloc]initWithFrame:CGRectMake(0,0,320,45)]autorelease];
        uview.layer.masksToBounds=YES;
        uview.backgroundColor = [UIColor whiteColor];
        UIImageView *numbackground =[[UIImageView alloc] initWithFrame:CGRectMake(4,3,41,41)]; 
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
        livrenum.text = [bookmaster_bookidarray objectAtIndex:section];
        

        UIImageView *detailback =[[UIImageView alloc] initWithFrame:CGRectMake(49,2,267,41)]; 
        detailback.image=[[UIImage alloc]init];
        detailback.image = [UIImage imageNamed:@"row.png"];
        
        UILabel *hadithcount = [[UILabel alloc]initWithFrame:CGRectMake(25,0,200,24)];
        [hadithcount setBackgroundColor:[UIColor clearColor]];
        hadithcount.textAlignment = UITextAlignmentLeft;
        [hadithcount setTextColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
        hadithcount.font = [UIFont fontWithName:@"Arial-ItalicMT" size:10];
       
        hadithcount.text = [NSString stringWithFormat:@"%d %@ %@",[[shorthadithdict objectForKey:[NSString stringWithFormat:@"%d",section]] count], NSLocalizedString(@"key9",@"" ),[hadithfavcountarray objectAtIndex:section]];
        
       
        
        UILabel *booktitle = [[UILabel alloc]initWithFrame:CGRectMake(20,10,210,30)];
        [booktitle setTextColor:[UIColor blackColor]];
        [booktitle setBackgroundColor:[UIColor clearColor]];
        booktitle.textAlignment = UITextAlignmentLeft;
        booktitle.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        booktitle.text = [bookmaster_booktitlearray objectAtIndex:section];
        
        [numbackground addSubview:livrelb];
        [numbackground addSubview:livrenum];
        [detailback addSubview:booktitle];
        [detailback addSubview:hadithcount];
        [uview addSubview:numbackground];
        [uview addSubview:detailback];
        
    }
    
    return uview;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    int sectionheight = 0;
    if (listingtableview.tag==1) {
        sectionheight = 1;
        listingtableview.sectionHeaderHeight = sectionheight;
    }
    else {
        sectionheight = 50;
        listingtableview.sectionHeaderHeight = sectionheight;
    }
    return sectionheight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    int cellHeight = 0;
    if (listingtableview.tag == 1) {
        cellHeight = 68;
        listingtableview.rowHeight = cellHeight;
    
    }
    else {
        cellHeight = 72;
        listingtableview.rowHeight = cellHeight;
        
    }
    return cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    if (listingtableview.tag == 1) {
        return [bookmaster_bookidarray count];
    
    }
    else {
        
        //rowcount = [hadithiddict objectForKey:[NSString stringWithFormat:@"%d",section]];
        return [[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",section]] count];
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
    if (listingtableview.tag == 1) 
    {
        UIView *uview2=[[[UIView alloc]initWithFrame:CGRectMake(1,3,320,65)]autorelease];
        uview2.layer.masksToBounds=YES;
        uview2.backgroundColor = [UIColor whiteColor];
        
        UIImageView *cellbackground =[[UIImageView alloc] initWithFrame:CGRectMake(47,0,267,60)]; 
        cellbackground.image = [UIImage imageNamed:@"Book-list_04.png"];
        
        UIImageView *numbackground =[[UIImageView alloc] initWithFrame:CGRectMake(2,0,43,42)]; 
        numbackground.image = [UIImage imageNamed:@"Book-list_05.png"];
        
        UIImageView *discloser =[[UIImageView alloc] initWithFrame:CGRectMake(245,20,13,21)]; 
        discloser.image = [UIImage imageNamed:@"redarrow.png"];
        
        UILabel *livrelb = [[UILabel alloc]initWithFrame:CGRectMake(0,4,42,10)];
        [livrelb setTextColor:[UIColor blackColor]];
        [livrelb setBackgroundColor:[UIColor clearColor]];
        livrelb.textAlignment = UITextAlignmentCenter;
        livrelb.font = [UIFont fontWithName:@"ArialMT" size:12];
        livrelb.text = NSLocalizedString(@"key12",@"" );
        
        UILabel *livrenum = [[UILabel alloc]initWithFrame:CGRectMake(0,11,42,30)];
        [livrenum setTextColor:[UIColor blackColor]];
        [livrenum setBackgroundColor:[UIColor clearColor]];
        livrenum.textAlignment = UITextAlignmentCenter;
        livrenum.font = [UIFont fontWithName:@"ArialMT" size:26];
        livrenum.text = [bookmaster_bookidarray objectAtIndex:indexPath.row];
        
        UILabel *hadithcount = [[UILabel alloc]initWithFrame:CGRectMake(25,0,200,24)];
        [hadithcount setTextColor:[UIColor blackColor]];
        [hadithcount setBackgroundColor:[UIColor clearColor]];
        [hadithcount setTextColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
        hadithcount.font = [UIFont fontWithName:@"Arial-ItalicMT" size:10];
        hadithcount.text = [NSString stringWithFormat:@"%d %@ %@",[[shorthadithdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]] count], NSLocalizedString(@"key9",@"" ),[hadithfavcountarray objectAtIndex:indexPath.row]];

       
        
        UILabel *booktitle = [[UILabel alloc]initWithFrame:CGRectMake(22,10,210,30)];
        [booktitle setTextColor:[UIColor blackColor]];
        [booktitle setBackgroundColor:[UIColor clearColor]];
        booktitle.textAlignment = UITextAlignmentLeft;
        booktitle.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        booktitle.text = [bookmaster_booktitlearray objectAtIndex:indexPath.row];
        
    
      
        float x =-25;
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(75,35,200,20)];
        scrollview.delegate = self;
      //  scrollview.bounces = NO;
        
        for (i=0; i<[[hadithnumdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]count]; i++) 
        {
           
            UILabel *hadithnumlb = [[UILabel alloc]initWithFrame:CGRectMake(x+25,0,20,20)];
            [hadithnumlb setTextColor:[UIColor blackColor]];
            [hadithnumlb setBackgroundColor:[UIColor clearColor]];
            hadithnumlb.textAlignment = UITextAlignmentCenter;
            hadithnumlb.font = [UIFont fontWithName:@"ArialMT" size:10];
         
            hadithnumlb.text =[NSString stringWithFormat:@"%@",[[NSArray arrayWithArray:[hadithnumdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]]objectAtIndex:i]];
           
            button = [Custombutton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(x+25,0,20,20);
            button.tag = [[NSString stringWithFormat:@"%@",[[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]]objectAtIndex:i]]intValue];
            button.booktitle = [bookmaster_booktitlearray objectAtIndex:indexPath.row];
            button.indexvalue = i;
            button.hadithidarr = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]]];
            
    
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
           
            x = hadithnumlb.frame.origin.x;
            
            if ([[[NSArray arrayWithArray:[hadithfavdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]]objectAtIndex:i]isEqual:@"Y"]) 
            {
                UIImageView *star =[[UIImageView alloc] initWithFrame:CGRectMake(x+21,4,10,9)]; 
                star.image = [UIImage imageNamed:@"Book-list_03.png"]; 
                x = x + star.frame.size.width;
                [scrollview addSubview:star];
            }
            UIImageView *cellsep =[[UIImageView alloc] initWithFrame:CGRectMake(x+22,3,1,13)]; 
            cellsep.image = [UIImage imageNamed:@"book-list_01.png"];
            
            [scrollview addSubview:button];
            [scrollview addSubview:cellsep];
            [scrollview addSubview:hadithnumlb];
            [hadithnumlb release];
            [cellsep release];
            
        }
        [scrollview setContentSize:CGSizeMake((x*1.2), 20)];
        
        [numbackground addSubview:livrelb];
        [numbackground addSubview:livrenum];
        [cellbackground addSubview:hadithcount];
        [cellbackground addSubview:booktitle];
        [cellbackground addSubview:discloser];
        [uview2 addSubview:numbackground];
        [uview2 addSubview:cellbackground];
        [uview2 addSubview:scrollview];
        [cell addSubview:uview2];


    }
    
    else 
    
    {
      UIView *uview2=[[[UIView alloc]initWithFrame:CGRectMake(0,0,320,70)]autorelease];
        uview2.layer.masksToBounds=YES;
        uview2.backgroundColor = [UIColor whiteColor];
       
        UIImageView *cellbackground =[[UIImageView alloc] initWithFrame:CGRectMake(4,0,313,67)]; 
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
        hadithnumlb.text = [[NSArray arrayWithArray:[hadithnumdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
        
    
        UILabel *hadithdetaillb = [[UILabel alloc]initWithFrame:CGRectMake(10,14,280,45)];
        [hadithdetaillb setTextColor:[UIColor blackColor]];
        [hadithdetaillb setBackgroundColor:[UIColor clearColor]];
        hadithdetaillb.textAlignment = UITextAlignmentLeft;
        hadithdetaillb.numberOfLines = 3;
        hadithdetaillb.adjustsFontSizeToFitWidth = YES;
        hadithdetaillb.font = [UIFont fontWithName:@"ArialMT" size:12];
        hadithdetaillb.text = [[NSArray arrayWithArray:[shorthadithdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
        float x = 0;
        if ([[[NSArray arrayWithArray:[hadithfavdict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row]isEqual:@"Y"]) 
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
        
        FMResultSet *result =[db executeQueryWithFormat: @"select * from hadith_chain where hadith_id=%@",[[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row]];
        
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
            [biotitledesc release];      
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
                    [biotitledesc release];

                    
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
        
       
       
    }
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [listingtableview deselectRowAtIndexPath:indexPath animated:YES];
    
     
    
    if (listingtableview.tag == 1) 
    {
        
        HadithsOfaBookViewController *gotohadithlisting = [[HadithsOfaBookViewController alloc]initWithNibName:@"HadithsOfaBookViewController" bundle:nil]; 
        gotohadithlisting.selectedbooktitle = [bookmaster_booktitlearray objectAtIndex:indexPath.row];
        gotohadithlisting.selectedbookid = [bookmaster_bookidarray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:gotohadithlisting animated:YES];
        [hadithiddict removeAllObjects];
        [bookmaster_bookidarray removeAllObjects];
        
        
    }
    else 
    {
       
        HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
        gotohadithdetail.selectedbooktitle = [bookmaster_booktitlearray objectAtIndex:indexPath.section];
        gotohadithdetail.hadithidforcounarray = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]];
        gotohadithdetail.selectedhadithid = [[NSArray arrayWithArray:[hadithiddict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]]objectAtIndex:indexPath.row];
        gotohadithdetail.i = indexPath.row;
        [self.navigationController pushViewController:gotohadithdetail animated:YES];
        [hadithiddict removeAllObjects];
        [bookmaster_bookidarray removeAllObjects];
    }

    
}

-(void)buttonClicked:(Custombutton *)sender{

   
    HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
    gotohadithdetail.hadithidforcounarray = sender.hadithidarr;
    gotohadithdetail.selectedbooktitle = sender.booktitle;
    gotohadithdetail.selectedhadithid = [NSString stringWithFormat:@"%d",sender.tag];
    gotohadithdetail.i = sender.indexvalue;
    [self.navigationController pushViewController:gotohadithdetail animated:YES];
    [hadithiddict removeAllObjects];
    [bookmaster_bookidarray removeAllObjects];

    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc {
    [liverbt release];
    [hadithbt release];
    [searchtextfield release];
    [listingtableview release];
    [backbt release];
    [super dealloc];
}

- (IBAction)crossbtn:(id)sender {
    if (searchtextfield.text.length >0) {
    searchtextfield.text = @"";
    [self searchingstart:sender];
    }
    
}

- (IBAction)liversliting:(id)sender {
    [searchtextfield resignFirstResponder];
    [liverbt setBackgroundImage:[UIImage imageNamed:@"livers1.png"] forState:UIControlStateNormal];
    [hadithbt setBackgroundImage:[UIImage imageNamed:@"hadith2.png"] forState:UIControlStateNormal];
    listingtableview.tag = 1;
    liverbt.userInteractionEnabled = NO;
     hadithbt.userInteractionEnabled = YES;
    [listingtableview reloadData];
}

- (IBAction)hadithlisting:(id)sender {
    [searchtextfield resignFirstResponder];
    [liverbt setBackgroundImage:[UIImage imageNamed:@"livers2.png"] forState:UIControlStateNormal];
    [hadithbt setBackgroundImage:[UIImage imageNamed:@"hadith1.png"] forState:UIControlStateNormal];
    listingtableview.tag = 2;
    hadithbt.userInteractionEnabled = NO;
    liverbt.userInteractionEnabled = YES;
    [listingtableview reloadData];
   
}


- (IBAction)searchingstart:(id)sender {
   
    [searchtextfield resignFirstResponder];
    
     
    [bookmaster_bookidarray removeAllObjects];
    [bookmaster_booktitlearray removeAllObjects];
    [hadithmaster_hadithidarray removeAllObjects];
    [hadithmaster_hadithnumarray removeAllObjects];
    [hadithmaster_shortdescarray removeAllObjects];
    [hadithmaster_hadithfav removeAllObjects];
    [hadithiddict removeAllObjects];
    [hadithnumdict removeAllObjects];
    [shorthadithdict removeAllObjects];
    [hadithfavdict removeAllObjects];
    [hadithfavcountarray removeAllObjects];
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    if (searchtextfield.text.length >0) 
    {
        
       
      //  NSString *p = @"%";
        NSString *temp =[NSString stringWithFormat:@"a"];
      
        FMResultSet *results = [db executeQuery: @"SELECT book_master.book_id,book_master.title FROM hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_title LIKE ? or book_master.title LIKE ? order by book_master.book_id",[NSString stringWithFormat:@"%%%@%%", searchtextfield.text],[NSString stringWithFormat:@"%%%@%%", searchtextfield.text]];
      
        while ([results next]) 
        {
            
            
            if (![temp isEqualToString:[results stringForColumn:@"book_id"]])
            {
                
                [bookmaster_bookidarray addObject:[results stringForColumn:@"book_id"]];
                [bookmaster_booktitlearray addObject:[results stringForColumn:@"title"]];
                temp = [results stringForColumn:@"book_id"];
                
            }
        }
    }
    else 
    {
        
        FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM book_master"];
        
        while ([results next])
        {
            
            [bookmaster_bookidarray addObject:[results stringForColumn:@"book_id"]];
            [bookmaster_booktitlearray addObject:[results stringForColumn:@"title"]];
            
        }
        
        
    }
    [self fillarrays];
   // [listingtableview reloadData];
}

   
- (IBAction)textfielddone:(id)sender {
    
    [bookmaster_bookidarray removeAllObjects];
    [bookmaster_booktitlearray removeAllObjects];
    [hadithmaster_hadithidarray removeAllObjects];
    [hadithmaster_hadithnumarray removeAllObjects];
    [hadithmaster_shortdescarray removeAllObjects];
    [hadithmaster_hadithfav removeAllObjects];
    [hadithiddict removeAllObjects];
    [hadithnumdict removeAllObjects];
    [shorthadithdict removeAllObjects];
    [hadithfavdict removeAllObjects];
    [hadithfavcountarray removeAllObjects];
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    if (searchtextfield.text.length >0) 
    {
        
        
        //  NSString *p = @"%";
        NSString *temp =[NSString stringWithFormat:@"a"];
       
        FMResultSet *results = [db executeQuery: @"SELECT book_master.book_id,book_master.title FROM hadith_master INNER JOIN book_master ON hadith_master.book_id = book_master.book_id WHERE hadith_master.hadith_title LIKE ? or book_master.title LIKE ? order by book_master.book_id",[NSString stringWithFormat:@"%%%@%%", searchtextfield.text],[NSString stringWithFormat:@"%%%@%%", searchtextfield.text]];
      
        while ([results next]) 
        {
            
            
            if (![temp isEqualToString:[results stringForColumn:@"book_id"]])
            {
                
                [bookmaster_bookidarray addObject:[results stringForColumn:@"book_id"]];
                [bookmaster_booktitlearray addObject:[results stringForColumn:@"title"]];
                temp = [results stringForColumn:@"book_id"];
                
            }
        }
    }
    else 
    {
        
        FMResultSet *results=[db executeQueryWithFormat: @"SELECT * FROM book_master"];
        
        while ([results next])
        {
            
            [bookmaster_bookidarray addObject:[results stringForColumn:@"book_id"]];
            [bookmaster_booktitlearray addObject:[results stringForColumn:@"title"]];
            
        }
        
        
    }
    [self fillarrays];
}

    
@end
