//
//  BiographyViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Quartzcore/Quartzcore.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "BiographyDetailViewController.h"

@interface BiographyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    ModelClass *mc;
    IBOutlet UIButton *backbtn;
    IBOutlet UILabel *headerlable;
    NSMutableArray *biographyidarray;
    NSMutableArray *titlearray;
    NSMutableArray *descriptionarray;
    IBOutlet UITableView *biographylistingtable;
   
}
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *headerlable;
@property (retain, nonatomic) IBOutlet UITableView *biographylistingtable;

@end
