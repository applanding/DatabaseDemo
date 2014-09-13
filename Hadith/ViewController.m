//
//  ViewController.m
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize hadithlb;
@synthesize biographylb;
@synthesize biographylb2;
@synthesize searchlb;
@synthesize favoritelb;
@synthesize settinglb;
@synthesize descriptionlb;
@synthesize hadithstapimgview;
@synthesize biographytapimgview;
@synthesize searchtapimgview;
@synthesize favouritetapimgview;
@synthesize settingtapimgview,pushhid,pushtitle;
int i;
bool detail;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil issyncing:(BOOL)issync{
   
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     
        if (issync) {
           
            mc=[[ModelClass alloc]init];
            [mc setDelegate:self];
            if (DELEGATE.isHostAvailable) {
                
                
            [mc getsynchronize:@selector(filldatabase:)];
            }
            else
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }

         //   NSDate *myDate = [NSDate date];
           // [[NSUserDefaults standardUserDefaults] setObject:myDate forKey:@"myDateKey"];
            
          //  NSDate *getDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"myDateKey"];
         //   NSTimeInterval timepost = [getDate timeIntervalSince1970];
         //   NSString *sendtime = [NSString stringWithFormat:@"%.f", timepost];
         //   NSLog(@"timeset of lastsynchro -> %@",sendtime);
           // edit = YES;
            
        }else {
          
           // edit = NO;
        }
    }
    return self;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil string:(BOOL)gotonext{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if (gotonext) {
           
            mc=[[ModelClass alloc]init];
            [mc setDelegate:self];
            if (DELEGATE.isHostAvailable) {
                
                detail = YES;  
                [mc getsynchronize:@selector(filldatabase:)];
            }
            else
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
            //   NSDate *myDate = [NSDate date];
            // [[NSUserDefaults standardUserDefaults] setObject:myDate forKey:@"myDateKey"];
            
            //  NSDate *getDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"myDateKey"];
            //   NSTimeInterval timepost = [getDate timeIntervalSince1970];
            //   NSString *sendtime = [NSString stringWithFormat:@"%.f", timepost];
            //   NSLog(@"timeset of lastsynchro -> %@",sendtime);
            // edit = YES;
            
        }else {
            
            // edit = NO;
        }
    }
    return self;



}



- (void)viewDidLoad
{
    [super viewDidLoad];
    hadithlb.font = [UIFont fontWithName:@"GABRIOLA" size:26];
    biographylb.font = [UIFont fontWithName:@"GABRIOLA" size:24];
    biographylb2.font = [UIFont fontWithName:@"GABRIOLA" size:24];
    searchlb.font = [UIFont fontWithName:@"GABRIOLA" size:26];
    favoritelb.font = [UIFont fontWithName:@"GABRIOLA" size:26];
    settinglb.font = [UIFont fontWithName:@"GABRIOLA" size:26];
    descriptionlb.font = [UIFont fontWithName:@"GABRIOLA" size:20];
    descriptionlb.numberOfLines =2;
    
    hadithlb.text =  NSLocalizedString(@"key1",@"" );
    biographylb.text =  NSLocalizedString(@"key2",@"" );
    biographylb2.text =  NSLocalizedString(@"key3",@"" );
    searchlb.text =  NSLocalizedString(@"key4",@"" );
    favoritelb.text =  NSLocalizedString(@"key5",@"" );
    settinglb.text =  NSLocalizedString(@"set6",@"" );
    descriptionlb.text =  NSLocalizedString(@"key7",@"" );
   
 

    
    UITapGestureRecognizer *TapHadith = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoHadith)] autorelease];
    [hadithstapimgview addGestureRecognizer:TapHadith];
    
    UITapGestureRecognizer *TapBiography = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoBiography)] autorelease];
    [biographytapimgview addGestureRecognizer:TapBiography];
    
    UITapGestureRecognizer *TapSearch = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoSearch)] autorelease];
    [searchtapimgview addGestureRecognizer:TapSearch];
    
    UITapGestureRecognizer *TapFavourite = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Gotofavourite)] autorelease];
    [favouritetapimgview addGestureRecognizer:TapFavourite];
    
    UITapGestureRecognizer *TapSetting = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoSetting)] autorelease];
    [settingtapimgview addGestureRecognizer:TapSetting];
     revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
     
}

   
    
-(void)viewDidAppear:(BOOL)animated{
   
    hadithstapimgview.image = nil;
    biographytapimgview.image = nil;
    searchtapimgview.image = nil;
    favouritetapimgview.image=nil;
    settingtapimgview.image=nil;    
    mc=[[ModelClass alloc]init];
    [mc setDelegate:self];

    
    if(DELEGATE.isHostAvailable)
    {
        
        NSString *currentVersion = (NSString*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSArray *prevStartupVersions = [[NSUserDefaults standardUserDefaults] arrayForKey:@"prevStartupVersions"];
        if (prevStartupVersions == nil)
        {
            // Starting up for first time with NO pre-existing installs (e.g., fresh
            // install of some version)
            
            [mc getsynchronize: @selector(filldatabase:)];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:currentVersion] forKey:@"prevStartupVersions"];
           
        }
        else
        {
            if (![prevStartupVersions containsObject:currentVersion])
            {
                // Starting up for first time with this version of the app. This
                // means a different version of the app was alread installed once
                // and started.
                
               
                [mc getsynchronize:@selector(filldatabase:)];
                
                NSMutableArray *updatedPrevStartVersions = [NSMutableArray arrayWithArray:prevStartupVersions];
                [updatedPrevStartVersions addObject:currentVersion];
                [[NSUserDefaults standardUserDefaults] setObject:updatedPrevStartVersions forKey:@"prevStartupVersions"];
              
                //NSDate *myDate = [NSDate date];
              //  [[NSUserDefaults standardUserDefaults] setObject:myDate forKey:@"myDateKey"];
                
               // NSDate *getDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"myDateKey"];
             //   NSTimeInterval timepost = [getDate timeIntervalSince1970];
             //   NSString *sendtime = [NSString stringWithFormat:@"%.f", timepost];
             //   NSLog(@"timeset of lastsynchro  -> %@",sendtime);
                
            }
        }
        
        // Save changes to disk
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
    


-(void)filldatabase:(NSDictionary *)results{
    
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  
    if ([result isEqualToString:@"true"]) {
        
    
    biographyidarray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"biography_id"]];
    // NSLog(@"biographyid =%@",biographyidarray);
    bio_descarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"description"]];
    bio_ibyarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"i_by"]];
    bio_idatearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"i_date"]];
    bio_isactive= [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"is_active"]];
    bio_isdeleted= [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"is_deleted"]];
    bio_titlearray =  [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"title"]];
    bio_typearray =  [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"type"]];
    bio_ubyarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"u_by"]];
    bio_udatearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"biography"]valueForKey:@"u_date"]];
    
    
    bookidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"book_id"]];
    book_descarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"description"]];
    book_ibyarray =  [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"i_by"]];
    book_idatearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"i_date"]];
    book_isactive = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"is_active"]];    
    book_isdelete =  [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"is_deleted"]];
    book_titlearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"title"]];
    book_typearray =   [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"type"]];
    book_ubyarray =  [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"u_by"]];
    book_udatearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"book"]valueForKey:@"u_date"]];
    
    
    hadith_bookid = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"book_id"]];
    hadith_commentarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"comments"]];
    hadith_haditharray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"hadith"]];
    hadithidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"hadith_id"]];
    hadithnumarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"hadith_num"]];
    hadith_ibyarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"i_by"]];
    hadith_idatearray=[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"i_date"]];
    hadith_isactive = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"is_active"]]; 
    hadith_isdelete = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"is_deleted"]];
    hadith_typearray=[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"type"]];
    hadith_ubyarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"u_by"]];
    hadith_udatearray=[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"u_date"]];
    hadith_titlearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"hadith"]valueForKey:@"title"]]; 
    
    chain_biographyidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"chain"]valueForKey:@"biography_id"]];
    chainidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"chain"]valueForKey:@"chain_id"]];
    chain_hadithidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"chain"]valueForKey:@"hadith_id"]];
    chain_typearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"chain"]valueForKey:@"type"]];
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    /*
    BOOL d= [db executeUpdate:@ "Delete from biography_master"];
    if (!d)
    {
        NSLog(@"delete failed biotable!!");
    }
    else {
        NSLog(@"successfully delete bio table");
        
    }
    NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    BOOL e = [db executeUpdate:@ "Delete from book_master"];
    if (!e)
    {
        NSLog(@"delete failed booktable!!");
    }
    else {
        NSLog(@"successfullydelete booktable");
        
    }
    NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    
    BOOL f = [db executeUpdate:@ "Delete from hadith_master"];
    if (!f)
    {
        NSLog(@"delete failed hadith table!!");
    }
    else {
        NSLog(@"successfully delete hadith table");
        
    }
    NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    
*/
    
    //biography table filling open
        
           
        
    
        
    for (i=0; i<[biographyidarray count]; i++) 
        
    {
        if([[bio_typearray objectAtIndex:i]isEqual:@"I"])
        {
            /*
            BOOL y= [db executeUpdate:[NSString stringWithFormat:@"insert into biography_master (ibiography_id,biography_id,title,description, is_active, is_deleted, i_by, i_date, u_by, u_date) values(?,?, ?, ?, ?, ?, ?, ?, ?,?)",nil,[biographyidarray objectAtIndex:i],[bio_titlearray objectAtIndex:i],[bio_descarray objectAtIndex:i],[bio_isactive objectAtIndex:i],[bio_isdeleted objectAtIndex:i],[bio_ibyarray objectAtIndex:i],[bio_idatearray objectAtIndex:i],[bio_ubyarray objectAtIndex:i],[bio_udatearray objectAtIndex:i]]];
            
            if (!y)
            {
                NSLog(@"insert failed biotable!!");
            }
            else {
                NSLog(@"successfully insert bio table");
                
            }
            NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            */
            sqlite3_stmt *stmt;
            int x;
            char *update = "insert into biography_master values(?,?, ?, ?, ?, ?, ?, ?, ?,?);";
            x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
            //  NSLog(@"x=%d",x);
            
            if (x == SQLITE_OK) 
            { 
                sqlite3_bind_text(stmt, 1, NULL,-1, NULL);	
                sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[biographyidarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 3,[[NSString stringWithFormat:@"%@",[bio_titlearray objectAtIndex:i]] UTF8String],-1, NULL); 
                sqlite3_bind_text(stmt, 4, [[NSString stringWithFormat:@"%@",[bio_descarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 5, [[NSString stringWithFormat:@"%@",[bio_isactive objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 6, [[NSString stringWithFormat:@"%@",[bio_isdeleted objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 7, [[NSString stringWithFormat:@"%@",[bio_ibyarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 8, [[NSString stringWithFormat:@"%@",[bio_idatearray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 9, [[NSString stringWithFormat:@"%@",[bio_ubyarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 10, [[NSString stringWithFormat:@"%@",[bio_udatearray objectAtIndex:i]] UTF8String],-1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE){
                NSLog(@"error biography master");
            }
            sqlite3_finalize(stmt);
        }
        else 
        {
            
            BOOL success = [db executeUpdateWithFormat:@"UPDATE biography_master SET title=%@,description=%@,is_active=%@,is_deleted=%@,i_by=%@,i_date=%@, u_by=%@,u_date=%@ where biography_id=%d",[bio_titlearray objectAtIndex:i],[bio_descarray objectAtIndex:i],[bio_isactive objectAtIndex:i],[bio_isdeleted objectAtIndex:i],[bio_ibyarray objectAtIndex:i],[bio_idatearray objectAtIndex:i],[bio_ubyarray objectAtIndex:i],[bio_udatearray objectAtIndex:i],[[biographyidarray objectAtIndex:i]intValue]];
            
            if (!success)
            {
                NSLog(@"update failed bio table!!");
            }
            else 
            {
                
                NSLog(@"successfully updated biotable");
                
            }
            
            NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
        }
        
    }//biography table filling close
    
    //book table filling start
    
    for(i=0; i <[bookidarray count];i++)
    {
        if([[book_typearray objectAtIndex:i]isEqual:@"I"]) {
            
            /*
            BOOL y= [db executeUpdate:[NSString stringWithFormat:@"insert into book_master (ibook_id,book_id,title,description, is_active, is_deleted, i_by, i_date, u_by, u_date) values(?,?, ?, ?, ?, ?, ?, ?, ?,?)",nil,[bookidarray objectAtIndex:i],[book_titlearray objectAtIndex:i],[book_descarray objectAtIndex:i],[book_isactive objectAtIndex:i],[book_isdelete objectAtIndex:i],[book_ibyarray objectAtIndex:i],[book_idatearray objectAtIndex:i],[book_ubyarray objectAtIndex:i],[book_udatearray objectAtIndex:i]]];
            
            if (!y)
            {
                NSLog(@"insert failed book table!!");
            }
            else {
                NSLog(@"successfully insert book table");
                
            }
            NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             */
            sqlite3_stmt *stmt;
            int x;
            char *update = "insert into book_master values(?,?, ?, ?, ?, ?, ?, ?, ?,?);";
            x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
            //  NSLog(@"x=%d",x);
            
            if (x == SQLITE_OK) 
            { 
                sqlite3_bind_text(stmt, 1, NULL,-1, NULL);	
                sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[bookidarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 3,[[NSString stringWithFormat:@"%@",[book_titlearray objectAtIndex:i]] UTF8String],-1, NULL); 
                sqlite3_bind_text(stmt, 4, [[NSString stringWithFormat:@"%@",[book_descarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 5, [[NSString stringWithFormat:@"%@",[book_isactive objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 6, [[NSString stringWithFormat:@"%@",[book_isdelete objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 7, [[NSString stringWithFormat:@"%@",[book_ibyarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 8, [[NSString stringWithFormat:@"%@",[book_idatearray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 9, [[NSString stringWithFormat:@"%@",[book_ubyarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 10, [[NSString stringWithFormat:@"%@",[book_udatearray objectAtIndex:i]] UTF8String],-1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE){
                NSLog(@"error book table");
            }
            sqlite3_finalize(stmt);
            
        }else {
            
            BOOL success = [db executeUpdateWithFormat:@"UPDATE book_master SET title=%@,description=%@,is_active=%@,is_deleted=%@,i_by=%@,i_date=%@, u_by=%@,u_date=%@ where book_id=%d",[book_titlearray objectAtIndex:i],[book_descarray objectAtIndex:i],[book_isactive objectAtIndex:i],[book_isdelete objectAtIndex:i],[book_ibyarray objectAtIndex:i],[book_idatearray objectAtIndex:i],[book_ubyarray objectAtIndex:i],[book_udatearray objectAtIndex:i],[[bookidarray objectAtIndex:i]intValue]];
            
            if (!success)
            {
                NSLog(@"update failed book table!!");
            }
            else 
            {
                
                NSLog(@"successfully updated booktable");
                
            }
            
            NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
        }
        
    } //book table filling done
    // hadith table filling start
    
    for (i=0; i<[hadithidarray count]; i++) {
        
        if ([[hadith_typearray objectAtIndex:i]isEqual:@"I"]) 
        {
            /*
            BOOL y= [db executeUpdate:[NSString stringWithFormat:@"insert into hadith_master (ihadith_id,hadith_id,book_id,hadith_num,hadith,comments, is_active, is_deleted, i_by, i_date, u_by, u_date,hadith_title,hadith_fav) values(?,?,?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?)",nil,[hadithidarray objectAtIndex:i],[hadith_bookid objectAtIndex:i],[hadithnumarray objectAtIndex:i],[hadith_haditharray objectAtIndex:i],[hadith_commentarray objectAtIndex:i],[hadith_isactive objectAtIndex:i],[hadith_isdelete objectAtIndex:i],[hadith_ibyarray objectAtIndex:i],[hadith_idatearray objectAtIndex:i],[hadith_ubyarray objectAtIndex:i],[hadith_udatearray objectAtIndex:i],[hadith_titlearray objectAtIndex:i],@"N"]];
            
            if (!y)
            {
                NSLog(@"insert failed hadith table!!");
            }
            else {
                NSLog(@"successfully insert hadith table");
                
            }
            NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            */
            sqlite3_stmt *stmt;
            int x;
            char *update = "insert into hadith_master values(?,?,?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?);";
            x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
            //  NSLog(@"x=%d",x);
            
            if (x == SQLITE_OK) 
            { 
                sqlite3_bind_text(stmt, 1, NULL,-1, NULL);	
                sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[hadithidarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 3,[[NSString stringWithFormat:@"%@",[hadith_bookid objectAtIndex:i]] UTF8String],-1, NULL); 
                sqlite3_bind_text(stmt, 4, [[NSString stringWithFormat:@"%@",[hadithnumarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 5, [[NSString stringWithFormat:@"%@",[hadith_haditharray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 6, [[NSString stringWithFormat:@"%@",[hadith_commentarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 7, [[NSString stringWithFormat:@"%@",[hadith_isactive objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 8, [[NSString stringWithFormat:@"%@",[hadith_isdelete objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 9, [[NSString stringWithFormat:@"%@",[hadith_ibyarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 10, [[NSString stringWithFormat:@"%@",[hadith_idatearray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 11, [[NSString stringWithFormat:@"%@",[hadith_ubyarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 12, [[NSString stringWithFormat:@"%@",[hadith_udatearray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 13, [[NSString stringWithFormat:@"%@",[hadith_titlearray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 14, [[NSString stringWithString:@"N"] UTF8String],-1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE){
                NSLog(@"error Hadith table");
            }
            sqlite3_finalize(stmt);
            
            
        }else 
        {
            
            BOOL success = [db executeUpdateWithFormat:@"UPDATE hadith_master SET book_id=%@,hadith_num=%@,hadith=%@,comments=%@,is_active=%@,is_deleted=%@,i_by=%@,i_date=%@, u_by=%@,u_date=%@, hadith_title=%@ where hadith_id=%d",[hadith_bookid objectAtIndex:i],[hadithnumarray objectAtIndex:i],[hadith_haditharray objectAtIndex:i],[hadith_commentarray objectAtIndex:i],[hadith_isactive objectAtIndex:i],[hadith_isdelete objectAtIndex:i],[hadith_ibyarray objectAtIndex:i],[hadith_idatearray objectAtIndex:i],[hadith_ubyarray objectAtIndex:i],[hadith_udatearray objectAtIndex:i],[hadith_titlearray objectAtIndex:i],[[hadithidarray objectAtIndex:i]intValue]];
            
            if (!success)
            {
                NSLog(@"update failed hadith table!!");
            }
            else 
            {
                
                NSLog(@"successfully updated hadith table");
                
            }
            
            NSLog(@"update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            
        }
        
        BOOL d= [db executeUpdateWithFormat:@ "Delete from hadith_chain WHERE hadith_id=%@",[hadithidarray objectAtIndex:i]];
        if (!d)
        {
            NSLog(@"delete failed chaintable!!");
        }
        else 
        {
            NSLog(@"successfully delete chain table");
            
        }
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        
               
    } //hadith table fiiling done
    //chain table filling start
    
    
    for (i=0; i<[chainidarray count]; i++) {
        
        if ([[chain_typearray objectAtIndex:i]isEqual:@"I"])
        {
            /*
            BOOL y= [db executeUpdate:[NSString stringWithFormat:@"insert into hadith_chain (ichain_id,chain_id,hadith_id,biography_id) values(?,?,?,?)",nil,[chainidarray objectAtIndex:i],[chain_hadithidarray objectAtIndex:i],[chain_biographyidarray objectAtIndex:i]]];
            
            if (!y)
            {
                NSLog(@"insert failed chain table!!");
            }
            else {
                NSLog(@"successfully insert chain table");
                
            }
            NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            */
            sqlite3_stmt *stmt;
            int x;
            char *update = "insert into hadith_chain values(?,?,?,?);";
            x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
            //  NSLog(@"x=%d",x);
            
            if (x == SQLITE_OK) 
            { 
                sqlite3_bind_text(stmt, 1, NULL,-1, NULL);	
                sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[chainidarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 3,[[NSString stringWithFormat:@"%@",[chain_hadithidarray objectAtIndex:i]] UTF8String],-1, NULL); 
                sqlite3_bind_text(stmt, 4, [[NSString stringWithFormat:@"%@",[chain_biographyidarray objectAtIndex:i]] UTF8String],-1, NULL);
                
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE){
                NSLog(@"error Hadith chain");
            }
            sqlite3_finalize(stmt);

            
            
        }
        
        else {
            
            BOOL success = [db executeUpdateWithFormat:@"UPDATE hadith_chain SET hadith_id=%@,biography_id=%@ where chain_id=%d",[chain_hadithidarray objectAtIndex:i],[chain_biographyidarray objectAtIndex:i],[[hadithidarray objectAtIndex:i]intValue]];
            
            if (!success)
            {
                NSLog(@"update failed chain table!!");
            }
            else 
            {
                
                NSLog(@"successfully updated chain table");
                
            }
            
            NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
        }
        
        
    } 
    //chain table filling done
    [db close]; 
    NSDate *myDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:myDate forKey:@"myDateKey"];
    
    NSDate *getDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"myDateKey"];
    NSTimeInterval timepost = [getDate timeIntervalSince1970];
    NSString *sendtime = [NSString stringWithFormat:@"%.f", timepost];
    NSLog(@"timeset of lastsynchro -> %@",sendtime);
        
        if (detail) {
            HadithDetailViewController *gotohadithdetail = [[HadithDetailViewController alloc]initWithNibName:@"HadithDetailViewController" bundle:nil];
            gotohadithdetail.selectedbooktitle = pushtitle;
            gotohadithdetail.selectedhadithid =pushhid;
            [self.navigationController pushViewController:gotohadithdetail animated:YES];   
            detail = NO;
        }
        
                
    }else {
        detail = NO;
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];

    }
}

-(void)GotoHadith{
   
   
       // hadithstapimgview.image = [UIImage imageNamed:@"Cell-selected_hd.png"];
        HadithsViewController *hadithview =[[HadithsViewController alloc]initWithNibName:@"HadithsViewController"bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:hadithview];
        navigationController.navigationBar.hidden = YES;
        [revealController setFrontViewController:navigationController animated:YES];
        [[self navigationController] pushViewController:hadithview animated:YES];
       
}
-(void)GotoBiography{
    
  
   // biographytapimgview.image = [UIImage imageNamed:@"Cell-selected_hd.png"];
    
    BiographyViewController *biographyview =[[BiographyViewController alloc]initWithNibName:@"BiographyViewController"bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:biographyview];
    navigationController.navigationBar.hidden = YES;
    [revealController setFrontViewController:navigationController animated:YES];
    [[self navigationController] pushViewController:biographyview animated:YES];
    [revealController hideFrontView];
   // [biographyview release];
    
}
-(void)GotoSearch{
    
   // searchtapimgview.image = [UIImage imageNamed:@"Cell-selected_hd.png"];
    SearchViewController *searchview =[[SearchViewController alloc]initWithNibName:@"SearchViewController"bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchview];
    navigationController.navigationBar.hidden = YES;
    [revealController setFrontViewController:navigationController animated:YES];
    [[self navigationController] pushViewController:searchview animated:YES];
    [revealController hideFrontView];
   // [searchview release];

}
-(void)Gotofavourite{
     
   // favouritetapimgview.image = [UIImage imageNamed:@"Cell-selected_hd.png"];
    FavouriteViewController *favouriteview =[[FavouriteViewController alloc]initWithNibName:@"FavouriteViewController"bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:favouriteview];
    navigationController.navigationBar.hidden = YES;
    [revealController setFrontViewController:navigationController animated:YES];
    [[self navigationController] pushViewController:favouriteview animated:YES];
    [revealController hideFrontView];
   // [favouriteview release];
    
}
-(void)GotoSetting{
     
   // settingtapimgview.image = [UIImage imageNamed:@"Cell-selected_hd.png"];
    SettingViewController *settingview =[[SettingViewController alloc]initWithNibName:@"SettingViewController"bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingview];
    navigationController.navigationBar.hidden = YES;
    [revealController setFrontViewController:navigationController animated:YES];
    [[self navigationController] pushViewController:settingview animated:YES];
   // [settingview release];
}



- (void)viewDidUnload
{
    [hadithlb release];
    hadithlb = nil;
    [biographylb release];
    biographylb = nil;
    [searchlb release];
    searchlb = nil;
    [favoritelb release];
    favoritelb = nil;
    [settinglb release];
    settinglb = nil;
    [self setHadithlb:nil];
    [self setBiographylb:nil];
    [self setSearchlb:nil];
    [self setFavoritelb:nil];
    [self setSettinglb:nil];
    [descriptionlb release];
    descriptionlb = nil;
    [self setDescriptionlb:nil];
    [self setHadithstapimgview:nil];
    [self setBiographytapimgview:nil];
    [self setSearchtapimgview:nil];
    [self setFavouritetapimgview:nil];
    [self setSettingtapimgview:nil];
    [self setBiographylb2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation = UIInterfaceOrientationPortrait);
}
*/ 

- (void)dealloc {
    [hadithlb release];
    [biographylb release];
    [searchlb release];
    [favoritelb release];
    [settinglb release];
    [hadithlb release];
    [biographylb release];
    [searchlb release];
    [favoritelb release];
    [settinglb release];
    [descriptionlb release];
    [descriptionlb release];
    [hadithstapimgview release];
    [biographytapimgview release];
    [searchtapimgview release];
    [favouritetapimgview release];
    [settingtapimgview release];
    [biographylb2 release];
    [super dealloc];
}
@end
