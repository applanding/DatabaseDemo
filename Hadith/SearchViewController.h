//
//  SearchViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "HadithDetailViewController.h"


@interface SearchViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UIButton *backbtn;
    IBOutlet UITableView *searchtableview;
    IBOutlet UITextField *searchtextfield;
    IBOutlet UIButton *searchbt;
    NSMutableArray *bookidarr;
    NSMutableArray *booktitlearr;
    NSMutableArray *hadithidarr;
    NSMutableArray *hadithnumarr;
    NSMutableArray *hadithtitle;
    NSMutableArray *hadithfavcountarr;
    NSMutableArray *hadithcountarr;
    NSMutableDictionary *hadithiddict;
    NSMutableDictionary *hadithnumdict;
    NSMutableDictionary *hadithtitledict;
   

}
- (IBAction)crossbtn:(id)sender;

- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *searchtextfield;
- (IBAction)gosearch:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *noresultlb;

@end
