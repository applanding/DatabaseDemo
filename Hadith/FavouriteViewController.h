//
//  FavouriteViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/quartzcore.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "ViewController.h"
#import "HadithDetailViewController.h"

@interface FavouriteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{



    IBOutlet UITableView *favhadithtableview;
    IBOutlet UIButton *backbtn;
    NSMutableArray *book_bookidarray;
    NSMutableArray *book_booktitlearray;
    NSMutableArray *hadith_hadithidarray;
    NSMutableArray *hadith_hadithnumarray;
    NSMutableArray *hadith_shortdescarray;
    NSMutableArray *hadith_idcount;
    NSMutableDictionary *hadith_iddict;
    NSMutableDictionary *hadith_numdict;
    NSMutableDictionary *shorthadith_dict;
    NSString *activeyes;
    NSString *deleteno ;
    
    
}
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *searchtextfield;

@end
