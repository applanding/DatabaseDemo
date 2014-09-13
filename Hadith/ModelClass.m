//
//  ModelClass.m
//  APITest
//// NSURL *url = [NSURL URLWithString:@"http://192.168.1.100/hadithapp/index.php/hadiths/sync"]; 
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelClass.h"
#import "ASIFormDataRequest.h"
#import "DarckWaitView.h"

@implementation ModelClass

@synthesize delegate = _delegate;
@synthesize temp;
@synthesize success;
@synthesize returnData = _returnData;

- (id)init
{
    self = [super init];
    if (self) {
        parser = [[SBJSON alloc] init];
        success = NO;
        drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
        drkSignUp = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    }
    
    return self;
}


-(void)getsynchronize:(SEL)sel{
    NSDate *getDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"myDateKey"];
  
    NSTimeInterval timepost = [getDate timeIntervalSince1970];
    NSString *sendtime = [NSString stringWithFormat:@"%.f", timepost];
    synchro = sel;
    NSURL *url = [NSURL URLWithString:@"PUT API HERE."];  
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:sendtime forKey:@"time_stamp"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drk showWithMessage:nil];

   
}


- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSString *func = [self getFunc:[request url]];
    
    if ([func isEqual:@"sync"]) {
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
    
        [self.delegate performSelector:synchro withObject:results];
        [drk hide];

    }

    
        
    
    
}


- (NSString *) getFunc:(NSURL *)url {
    NSString *str = [NSString stringWithFormat:@"%@",url];
    NSArray *arr = [str componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"/"]];
    return [arr lastObject];
}

@end
