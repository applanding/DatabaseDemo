//
//  HadithsViewController.h
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
#import "HadithDetailViewController.h"
#import "HadithsOfaBookViewController.h"
#import "ViewController.h"
#import "Custombutton.h"

@interface HadithsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>{

    IBOutlet UIButton *liverbt;
    IBOutlet UIButton *hadithbt;
    IBOutlet UITableView *listingtableview;
    UIView *uview;
    NSMutableArray *bookmaster_bookidarray;
    NSMutableArray *bookmaster_booktitlearray; 
    NSMutableArray *hadithmaster_hadithidarray;
    NSMutableArray *hadithmaster_hadithnumarray;
    NSMutableArray *hadithmaster_shortdescarray;
    NSMutableArray*hadithmaster_hadithfav;
    NSMutableDictionary *hadithiddict;
    NSMutableDictionary *hadithnumdict;
    NSMutableDictionary *shorthadithdict;
    NSMutableDictionary *hadithfavdict;
    NSMutableArray *hadithfavcountarray;
    IBOutlet UIButton *backbt;
    Custombutton *button;
    


}



@property (retain, nonatomic) IBOutlet UITextField *searchtextfield;
- (IBAction)crossbtn:(id)sender;


- (IBAction)liversliting:(id)sender;
- (IBAction)hadithlisting:(id)sender;
- (IBAction)searchingstart:(id)sender;

@end
