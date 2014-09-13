//
//  HadithsOfaBookViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 25/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/quartzcore.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "HadithDetailViewController.h"

@interface HadithsOfaBookViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{

    IBOutlet UITableView *hadithslistingtableview;
    IBOutlet UIButton *backbtn;
    NSString *selectedbookid;
    NSMutableArray *hadithidarray;
    NSMutableArray *shorthaditharray;
    NSMutableArray *hadithnumarray;
    NSMutableArray *hadithfav;
    IBOutlet UILabel *booktitlelb;
    NSString *selectedbooktitle;
    IBOutlet UITextField *searchtextfield;
    IBOutlet UIButton *searchbt;
   
    
}
- (IBAction)crossbt:(id)sender;


- (IBAction)gosearch:(id)sender;

- (IBAction)goback:(id)sender;
@property (nonatomic,retain) NSString *selectedbookid;
@property (retain, nonatomic) IBOutlet UILabel *booktitlelb;
@property (retain, nonatomic) IBOutlet UILabel *hadithcountlb;

@property (retain, nonatomic) NSString *selectedbooktitle;


@end
