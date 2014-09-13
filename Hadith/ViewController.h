//
//  ViewController.h
//  Hadith
//
//  Created by Peerbits Solution on 15/08/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HadithsViewController.h"
#import "BiographyViewController.h"
#import "SearchViewController.h"
#import "FavouriteViewController.h"
#import "SettingViewController.h"
#import "ModelClass.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "RevealController.h"
@interface ViewController : UIViewController{

   
    ModelClass *mc;
    IBOutlet UILabel *hadithlb;
    IBOutlet UILabel *biographylb;
    IBOutlet UILabel *searchlb;
    IBOutlet UILabel *favoritelb;
    IBOutlet UILabel *settinglb;
    IBOutlet UILabel *descriptionlb;
    NSMutableArray *biographyidarray;
    NSMutableArray *bio_descarray;
    NSMutableArray *bio_ibyarray;
    NSMutableArray *bio_idatearray;
    NSMutableArray *bio_isactive;
    NSMutableArray *bio_isdeleted;
    NSMutableArray *bio_titlearray;
    NSMutableArray *bio_typearray;
    NSMutableArray *bio_ubyarray;
    NSMutableArray *bio_udatearray;
    NSMutableArray *bookidarray;
    NSMutableArray *book_descarray;
    NSMutableArray *book_ibyarray;
    NSMutableArray *book_idatearray;
    NSMutableArray *book_isactive;
    NSMutableArray *book_isdelete;
    NSMutableArray *book_titlearray;
    NSMutableArray *book_typearray;
    NSMutableArray *book_ubyarray;
    NSMutableArray *book_udatearray;
    NSMutableArray *hadith_bookid;
    NSMutableArray *hadith_commentarray;
    NSMutableArray *hadith_haditharray;
    NSMutableArray *hadithidarray;
    NSMutableArray *hadith_titlearray;
    NSMutableArray *hadithnumarray;
    NSMutableArray *hadith_ibyarray;
    NSMutableArray *hadith_idatearray;
    NSMutableArray *hadith_isactive;
    NSMutableArray *hadith_isdelete;
    NSMutableArray *hadith_typearray;
    NSMutableArray *hadith_ubyarray;
    NSMutableArray *hadith_udatearray;
    NSMutableArray *chainidarray;
    NSMutableArray *chain_biographyidarray;
    NSMutableArray *chain_hadithidarray;
    NSMutableArray *chain_typearray;
   
    RevealController *revealController;
    
    
}

@property (retain, nonatomic) IBOutlet UILabel *hadithlb;
@property (retain, nonatomic) IBOutlet UILabel *biographylb;
@property (retain, nonatomic) IBOutlet UILabel *biographylb2;
@property (retain, nonatomic) IBOutlet UILabel *searchlb;
@property (retain, nonatomic) IBOutlet UILabel *favoritelb;
@property (retain, nonatomic) IBOutlet UILabel *settinglb;
@property (retain, nonatomic) IBOutlet UILabel *descriptionlb;
@property (retain, nonatomic) IBOutlet UIImageView *hadithstapimgview;
@property (retain, nonatomic) IBOutlet UIImageView *biographytapimgview;
@property (retain, nonatomic) IBOutlet UIImageView *searchtapimgview;
@property (retain, nonatomic) IBOutlet UIImageView *favouritetapimgview;
@property (retain, nonatomic) IBOutlet UIImageView *settingtapimgview;
@property (retain, nonatomic) NSString *pushhid;
@property (retain, nonatomic) NSString *pushtitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil issyncing:(BOOL)issync;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil string:(BOOL)gotonext;
@end
