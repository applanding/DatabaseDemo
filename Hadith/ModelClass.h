//
//  ModelClass.h
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMSocialShare/JSON.h"

@class DarckWaitView;

@interface ModelClass : NSObject {
    SBJSON *parser;
   /* SEL seignInSel;
    SEL seignUpSel;
    SEL subCatSel;
    SEL friendSel;
    SEL sublistSel;
    SEL statchSel;
    SEL historySel;
    SEL historySelHis;
    SEL celebretySel;
    SEL populareSel; */
    SEL synchro;
    NSString *temp;
    DarckWaitView *drk;
    DarckWaitView *drkSignUp;
}
@property (nonatomic, retain)  NSString *temp;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) id returnData;
@property (nonatomic, readwrite) BOOL success;
//- (void) signIn:(NSString *)email password:(NSString *)pasw selector:(SEL)sel;
//- (NSArray *) getCategories;

/*
- (void)getPopulare:(NSInteger)subCategoryId userId:(NSInteger)userId selector:(SEL)sel;

- (void) getSubCategoriesForCatId:(NSInteger)catId selector:(SEL)sel;
- (void)getSublistForSubCatId:(NSInteger)catId selector:(SEL)sel;
- (void)getHistoryForCelebrity:(NSInteger)celId selector:(SEL)sel;

- (void)getHistoryForCelebrityHis:(NSInteger)UserId selector:(SEL)sel ;

- (NSArray *)getHistoryForCelebrityarray:(NSInteger)celId selector:(SEL)sel;

- (void)getCelebrityForID:(NSInteger)celId selector:(SEL)sel;

-(NSArray *) getWhoSnaches;


- (void) frlist:(NSString *)ide name:(NSString *)nm picture:(NSString *)photo gender:(NSString *)gdr birthday:(NSString *)bdate userid:(NSString *)uid selector:(SEL)sel;

- (void) signUpEmail:(NSString *)email password:(NSString *)pasw name:(NSString *)name phone:(NSString *)phone 
              gender:(NSInteger)gender birthdate:(NSDate *)birthdate photo:(NSData *)photo selector:(SEL)sel;

- (NSString *) getFunc:(NSURL *)url;


- (NSArray*)getCategories;
- (void)getLanguage;
- (BOOL) validateEmail: (NSString *)candidate;
 */
- (NSString *) getFunc:(NSURL *)url;
-(void)getsynchronize:(SEL)sel;

/*- (void) gosnatchWithCelebrity:(NSInteger)celId userId:(NSInteger)userId prise:(NSInteger)price snachedBy:(NSInteger)snachedBy selector:(SEL)sel;*/

@end
